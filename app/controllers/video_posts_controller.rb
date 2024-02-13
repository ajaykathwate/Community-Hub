class VideoPostsController < ApplicationController

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

    if @video_post.save
      turbo_stream.append :video_posts, partial: 'video_posts/video_post', locals: { video_post: @video_post }, notice:"Post Created Successfully!"
    else
      render :new, notice:"Error occured while creating community, Try again!"
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
