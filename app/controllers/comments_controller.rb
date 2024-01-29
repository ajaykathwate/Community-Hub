class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @e_learning_chat_room = ELearningChatRoom.find(params[:e_learning_chat_room_id])
    @video_post = @e_learning_chat_room.video_posts.find(params[:video_post_id])
    @comment = @video_post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      turbo_stream.append :comments, partial: 'comments/comment', locals: { comment: @comment }
    else
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
