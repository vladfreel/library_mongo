# Likes
class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    @like = @book.likes.create(like_params)
    respond_to do |format|
      format.html { redirect_to book_path(@book.id) }
      format.js
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @like = @book.likes.find(params[:id])
    @like.delete
    respond_to do |format|
      format.html { redirect_to book_path(@book.id) }
      format.js
    end
  end

  private

  def like_params
    params.require(:like).permit(:book_id, :user_id)
  end
end
