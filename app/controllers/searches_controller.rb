class SearchesController < ApplicationController
  def index
    if params.dig(:query).present?
      # video_posts
      @video_posts = VideoPost.containing(params[:query])
      # users
      @users = User.containing(params[:query])
      # communities
      @Communities = Community.containing(params[:query])
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
end
