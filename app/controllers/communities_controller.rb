class CommunitiesController < ApplicationController

  # allow only authenticated user to access these pages
  before_action :authenticate_user, only: [:index]

  # show page to display a community info
  def show
    @single_community = Community.find(params[:id])

    @single_chatroom = @single_community.chat_room

    if @single_community.topic == 'E-Learning'
      @e_learning_chat_room = @single_community.e_learning_chat_room
      @video_post = VideoPost.new
      @video_posts = @e_learning_chat_room.video_posts.order(created_at: :desc)
    end

    @current_user = current_user

    @message = Message.new
    @messages = @single_chatroom.messages.order(created_at: :asc)

    @community = Community.new
    @communities = current_user.communities

    @community_members = User.all_except(current_user)

    @community_admin = User.find(@single_community.admin_id)

    @pending_requests = @single_community.join_requests.where(accepted: false)

    @matches = fetch_cricket_data

    render 'index'
  end

  def fetch_cricket_data
    apikey = "5d50503b-36c0-468d-a237-8042ddf2c53a"
    url = "https://api.cricapi.com/v1/matches?apikey=#{apikey}&offset=0"
    response = RestClient.get(url)
    data = JSON.parse(response.body)
    data['data']
  rescue RestClient::ExceptionWithResponse => e
    puts "Error fetching data from the API: #{e.response.body}"
    nil
  end

  # index page with "/app" route
  def index
    @community = Community.new
    @communities = current_user.communities
    @users = User.all
    @user_id = current_user.id

    # all messages of all communities a user is part of
    @all_messages = Message.joins(chat_room: { community: :community_users }).where(community_users: { user_id: @user_id }).order('messages.created_at DESC')

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

    # whenever a new community is created then a new chatroom is also created
    # If a user opt for E-Learning or sports community then that community is also created along with main ChatRoom

    # save community and chatroom both
    if @community.save
      current_user.communities << @community

      # ChatRoom is created
      @chat_room = ChatRoom.create(community: @community)
      # E-Learning or Sports chatroom is created
      if @community.topic == 'E-Learning'
        ELearningChatRoom.create(community: @community)
      elsif @community.topic == 'Sports'
        SportsChatRoom.create(community: @community)
      end
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
      redirect_to app_path, notice: "Community Updated Successfully!"
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
