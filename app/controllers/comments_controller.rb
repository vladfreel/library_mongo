class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.create!(comment_params)
    respond_to do |format|
      format.html { redirect_to book_path(@book) }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
