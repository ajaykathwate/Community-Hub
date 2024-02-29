class VideoPostsController < ApplicationController

  # allow only authenticated user to access these pages and those who has atleast three interests
  before_action :authenticate_user
  before_action :has_three_interests

  def new
    @e_learning_chat_room = ELearningChatRoom.new
  end

  def show
    @video_post = VideoPost.find(params[:id])
  end

  def create
    @e_learning_chat_room = ELearningChatRoom.find(params[:e_learning_chat_room_id])
    @video_post = @e_learning_chat_room.video_posts.build(post_params.except(:tags))
    @video_post.user = current_user
    create_or_delete_video_posts_tags(@video_post, params[:video_post][:tags])
    @user = current_user

    if @video_post.save
      # debugger
      puts "*****************************"
      puts "Current User: #{current_user}"
      puts "*****************************"
      render turbo_stream: turbo_stream.prepend(:video_posts, partial: 'video_posts/video_post', locals:{ video_post: @video_post, current_user: @user })
      puts "Post saved....................."
    else
      render :new, notice:"Post not created successfully, try again!"
    end
  end

  def edit
    @e_learning_chat_room = ELearningChatRoom.find(params[:e_learning_chat_room_id])
    @video_post = VideoPost.find(params[:id])
  end

  def update
    @e_learning_chat_room = ELearningChatRoom.find(params[:e_learning_chat_room_id])
    @video_post = VideoPost.find(params[:id])
    @user = current_user
    create_or_delete_video_posts_tags(@video_post, params[:video_post][:tags])
    if @video_post.update(post_params.except(:tags))
      render turbo_stream: turbo_stream.prepend(:video_posts, partial: 'video_posts/video_post', locals:{ video_post: @video_post, current_user: @user })
      # redirect_to app_path, notice: "VideoPost Updated Successfully!"
    else
      render edit_communities_path(@community)
    end
  end

  def delete_post
    @video_post = VideoPost.find(params[:id])
    if @video_post.destroy
      Rails.logger.info("Deleted Post successfully.")
      redirect_to app_path, notice:"Video Post deleted successfully!"
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

  # has more than three interests selected after signup
  def has_three_interests
    if current_user.interests.count < 3
      redirect_to user_interests_path(id: current_user.id)
    end
  end

  private
  def create_or_delete_video_posts_tags(video_post, tags)
    video_post.taggables.destroy_all
    tags = tags.strip.split(",")
    tags.each do |tag|
      video_post.tags << Tag.find_or_create_by(name: tag)
    end
  end

  def post_params
    params.require(:video_post).permit(:title, :user_id, :likes, :video_file, :tags)
  end

end
