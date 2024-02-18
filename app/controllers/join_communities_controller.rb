class JoinCommunitiesController < ApplicationController


  # allow only authenticated user to access these pages
  before_action :authenticate_user, only: [:index, :join, :show]

  def index
    # communities a user os not part of
    @communities = Community.order(created_at: :asc).where.not(id: current_user.communities.pluck(:id))
  end

  def show
    @user = User.find(params[:id])
    @community = Community.find(params[:community_id])
    @joined = false;
    current_user.communities.each do |c|
      if c.id == @community.id
        @joined = true
      end
    end
  end

    # a user added to the communities
  def join
    @community = Community.find(params[:id])
    @community_admin = User.find(@community.admin_id)
    unless current_user.communities.include?(@community)
      current_user.communities << @community
      LikeNotifier.with(message: "#{current_user.name} has joined the community").deliver_later(@community_admin)
      turbo_stream.prepend "notifications_#{@community_admin.id}",
        target: "notifications_#{@community_admin.id}",
        partial: "comment_notifier/notifications/join_notification",
        locals: { user: @community_admin, unread: true }
    end
    redirect_to community_path(@community)
  end

  # requests to join community
  def join_request
    @user = current_user
    @community = Community.find(params[:id])
    @community_admin = User.find(@community.admin_id)
    @all_join_requests = JoinRequest.all
    # Create a join request
    @join_request = JoinRequest.new(user: @user, community: @community, accepted: false)
    unless @all_join_requests.include?(@join_request)
      if @join_request.save
        puts "request sent!"
        LikeNotifier.with(message: "#{current_user.name} requested to join your community").deliver_later(@community_admin)
        turbo_stream.prepend "notifications_#{@community_admin.id}",
          target: "notifications_#{@community_admin.id}",
          partial: "comment_notifier/notifications/join_request_notification",
          locals: { user: @community_admin, unread: true }
      end
    end
    redirect_to @community
  end

  # accept the join community request
  def accept_request
    # fetch the join comunity request and find @community and @request_user from it.
    @accept_join_request = JoinRequest.find(params[:id])
    @community = Community.find(@accept_join_request.community_id)
    @requested_user = User.find(@accept_join_request.user_id)

    # if both the value are present then only add the user to the community.
    if @requested_user && @community
      unless @community.users.include?(@requested_user)
        @community.users << @requested_user
        @accept_join_request.update(accepted: true)
        LikeNotifier.with(message: "#{current_user.name} requested to join your community").deliver_later(@community_admin)
        turbo_stream.prepend "notifications_#{@community_admin.id}",
          target: "notifications_#{@community_admin.id}",
          partial: "comment_notifier/notifications/join_request_notification",
          locals: { user: @community_admin, unread: true }
      end
      redirect_to @community
    end
  end

  def reject_request
    # fetch the join comunity request and find @community and @request_user from it.
    @accept_join_request = JoinRequest.find(params[:id])
    @community = Community.find(@accept_join_request.community_id)
    @community_admin = User.find(@community.admin_id)
    @requested_user = User.find(@accept_join_request.user_id)
     if @requested_user && @community
      JoinRequest.where(user_id: @requested_user.id, community_id: @community.id).destroy_all
      LikeNotifier.with(message: "#{@community.name} rejected you join request").deliver_later(@requested_user)
      turbo_stream.prepend "notifications_#{@requested_user.id}",
        target: "notifications_#{@requested_user.id}",
        partial: "comment_notifier/notifications/reject_request_notification",
        locals: { user: @community, unread: true }
      redirect_to app_path
      else
      redirect_to app_path
    end
  end

  # leave community
  def leave_community
    @leave_community = Community.find(params[:id])
    @community_admin = User.find(@leave_community.admin_id)
    Rails.logger.info("Attempting to leave community #{params[:id]} for user #{current_user.id}")

    # Remove the user from the community
    current_user.communities.delete(@leave_community)

    unless current_user.communities.include?(@leave_community)
      # Notify the community admin only if the user successfully left the community
      LikeNotifier.with(message: "#{current_user.name} left the community").deliver_later(@community_admin)
      turbo_stream.prepend "notifications_#{@community_admin.id}",
        partial: "comment_notifier/notifications/leave_notification",
        locals: { user: @community_admin, unread: true }
      Rails.logger.info("Left community successfully.")
    end

    redirect_to app_path
  end


  def delete_community
    @community = Community.find(params[:id])
    if @community.destroy
      Rails.logger.info("Deleted community successfully.")
      redirect_to app_path, notice:"Community Deleted Successfully!"
    else
      redirect_to :back
    end
  end

    # check if the user is authenticated
  def authenticate_user
    if !current_user
      session[:fall_back_url] = request.url
      redirect_to new_user_sessions_path
    end
  end

end
