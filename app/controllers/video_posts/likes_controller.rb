class VideoPosts::LikesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_video_post

  def update
    if @video_post.liked_by?(current_user)
      @video_post.unlike(current_user)
    else
      @video_post.like(current_user)
    end
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(dom_id(@video_post, :likes), partial: 'video_posts/likes', locals:{video_post: @video_post})
       }
    end
  end

  private
  def set_video_post
    @video_post = VideoPost.find(params[:video_post_id])
  end

end
