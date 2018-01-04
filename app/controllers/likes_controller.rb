# Likes
class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_book, only: [:create, :destroy]
  def create
    @like = @book.likes.create(like_params)
    respond_to do |format|
      format.html { redirect_to book_path(@book.id) }
      format.js
    end
  end

  def destroy
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

  def find_book
    @book = Book.find(params[:book_id])
  end
end
