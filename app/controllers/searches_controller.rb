class SearchesController < ApplicationController

  # allow only authenticated user to access these pages and those who has atleast three interests
  before_action :authenticate_user
  before_action :has_three_interests

  def index
    if params.dig(:query).present?
      # video_posts
      @video_posts = VideoPost.containing(params[:query])
      # users
      @users = User.containing(params[:query])
      # communities
      @communities_all = Community.containing(params[:query])
      # messages
      @messages = Message.includes(:post_image_attachment).where.not(post_image_attachment: { id: nil }).containing(params[:query])
      # tags
      @tags = Tag.containing(params[:query])
      # combined records
      @shuffled_records = @video_posts + @messages
    else
      @video_posts = []
      @users = []
      @communities = []
      @messages = []
      @tags = []
    end
  end

  # check if the user is authenticated
  def authenticate_user
    if !current_user
      redirect_to new_user_sessions_path
    end
  end

  # has more than three interests selected after signup
  def has_three_interests
    if current_user.interests.count < 3
      redirect_to user_interests_path(id: current_user.id)
    end
  end

end
