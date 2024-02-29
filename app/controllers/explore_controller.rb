class ExploreController < ApplicationController

  # allow only authenticated user to access these pages and those who has atleast three interests
  before_action :authenticate_user
  before_action :has_three_interests

  def index
    @video_posts_all = VideoPost.all

    user_interests = current_user.interests.pluck(:name)

    @video_posts = VideoPost.where("title LIKE ?", "%#{user_interests.join('%')}%")

    @shuffled_records

    if @video_posts.count > 0
      @shuffled_records = @video_posts
    else
      @shuffled_records = @video_posts_all
    end

    # all tags
    @tags = Tag.all.sort_by(&:name)

    @users_with_same_interests = User.joins(:interests).where(interests: { name: user_interests }).where.not(id: current_user.id).distinct

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
