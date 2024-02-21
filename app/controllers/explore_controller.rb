class ExploreController < ApplicationController

  # allow only authenticated user to access these pages and those who has atleast three interests
  before_action :authenticate_user
  before_action :has_three_interests

  def index
    @video_posts_all = VideoPost.all

    @messages_all = Message.includes(:post_image_attachment).where.not(post_image_attachment: { id: nil })

    @combined_records_all = @video_posts_all + @messages_all

    user_interests = current_user.interests.pluck(:name)

    @video_posts = VideoPost.where("title LIKE ?", "%#{user_interests.join('%')}%")

    @messages = Message.includes(:post_image_attachment).where("content LIKE ?", "%#{user_interests.join('%')}%").where.not(post_image_attachment: { id: nil })

    @combined_records_with_interests = (@video_posts + @messages)

    @shuffled_records

    if @combined_records_with_interests.count > 0
      @shuffled_records = @combined_records_with_interests
    else
      @shuffled_records = @combined_records_all
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
