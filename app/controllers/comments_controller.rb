class CommentsController < ApplicationController

  # allow only authenticated user to access these pages and those who has atleast three interests
  before_action :authenticate_user
  before_action :has_three_interests
  before_action :set_e_chat_room_and_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = @video_post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      turbo_stream.prepend :comments, partial: 'comments/comment', locals: { comment: @comment, video_post: @video_post }
    else
      render :new
    end
  end

  private

  def set_e_chat_room_and_post
    @e_chat_room = ELearningChatRoom.find(params[:e_learning_chat_room_id])
    @video_post = @e_chat_room.video_posts.find(params[:video_post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
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
