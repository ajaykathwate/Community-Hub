class SearchesController < ApplicationController
  def index
    if params.dig(:query).present?
      @video_posts = VideoPost.containing(params[:query])
      @users = User.containing(params[:query])
      @Communities = Community.containing(params[:query])
    else
      @video_posts = []
      @users = []
      @communities = []
    end
  end
end
