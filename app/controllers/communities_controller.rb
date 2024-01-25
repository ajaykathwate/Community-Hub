class CommunitiesController < ApplicationController

  # allow only authenticated user to access these pages
  before_action :authenticate_user, only: [:index]

  # show page to display a community info
  def show
    @single_community = Community.find(params[:id])

    @single_chatroom = @single_community.chat_room

    @current_user = current_user

    @message = Message.new
    @messages = @single_chatroom.messages.order(created_at: :asc)

    @community = Community.new
    @communities = current_user.communities

    @community_members = User.all_except(current_user)

    @community_admin = User.find(@single_community.admin_id)

    @pending_requests = @single_community.join_requests.where(accepted: false)

    render 'index'
  end

  # index page with "/app" route
  def index
    @community = Community.new
    @communities = current_user.communities
    @users = User.all
    @user_id = current_user.id

    # all messages of all communities a user is part of
    @all_messages = Message.joins(chat_room: { community: :community_users })
                      .where(community_users: { user_id: @user_id })
                      .order('messages.created_at DESC')

    render 'index'
  end

  # new action for creating a new community
  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    # setting admin_id using current_user.id
    @community.admin_id = current_user.id

    # NEW ADDED
    # whenever a new community is created then a new chatroom is also created

    # save community and chatroom both
    if @community.save
      current_user.communities << @community
      @chat_room = ChatRoom.create(community: @community)
      # redirect_to create_chat_room_chat_rooms_path(@community)
      # render template: "chat_rooms_controller/create_chat_room"
      redirect_to app_path
    else
      render :new
    end
  end


  def edit
    @community = Community.find(params[:id])
  end

  def update
    @community = Community.find(params[:id])
    if @community.update(community_params)
      redirect_to app_path
    else
      render edit_communities_path(@community)
    end
  end

  # community_params action
  private
  def community_params
    params.require(:community).permit(:name, :topic, :about, :isPrivate, :community_profile)
  end

  # check if the user is authenticated
  def authenticate_user
    if !current_user
      redirect_to new_user_sessions_path
    end
  end

end
