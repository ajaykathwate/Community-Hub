class JoinCommunitiesController < ApplicationController


  # allow only authenticated user to access these pages
  before_action :authenticate_user, only: [:index, :join]

  def index
    # communities a user os not part of
    @communities = Community.where.not(id: current_user.communities.pluck(:id))

  end

    # a user added to the communities
  def join
    @community = Community.find(params[:id])
    current_user.communities << @community
    redirect_to app_path, notice: "You have joined the community successfully."
  end

  # requests to join community
  def join_request
    @user = current_user
    @community = Community.find(params[:id])
    # Create a join request
    @join_request = JoinRequest.new(user: @user, community: @community, accepted: false)
    if @join_request.save
      puts "request sent!"
      redirect_to app_path
    end
  end

  # accept the join community request
  def accept_request
    # fetch the join comunity request and find @community and @request_user from it.
    @accept_join_request = JoinRequest.find(params[:id])
    @community = Community.find(@accept_join_request.community_id)
    @requested_user = User.find(@accept_join_request.user_id)

    # if both the value are present then only add the user to the community.
    if @requested_user && @community
      @community.users << @requested_user
      @accept_join_request.update(accepted: true)
      redirect_to app_path
    else
      redirect_to app_path
    end
  end

  # leave community
  def leave_community
    @leave_community = Community.find(params[:id])
    Rails.logger.info("Attempting to leave community #{params[:id]} for user #{current_user.id}")
    # Assuming you have a join table for user and community called `community_users`
    current_user.communities.delete(@leave_community)
    Rails.logger.info("Left community successfully.")
    redirect_to app_path
  end

  def delete_community
    @community = Community.find(params[:id])
    if @community.destroy
      Rails.logger.info("Deleted community successfully.")
      redirect_to app_path
    else
      redirect_to :back
    end
  end

    # check if the user is authenticated
  def authenticate_user
    if !current_user
      redirect_to new_user_sessions_path
    end
  end

end
