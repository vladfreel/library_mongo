class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @comment = Comment.new
  end
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(comment_params)
    @comment.save!
    redirect_to book_path(@book.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
