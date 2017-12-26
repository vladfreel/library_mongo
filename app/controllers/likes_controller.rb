class LikesController < ApplicationController
  before_action :authenticate_user!
  def mew
    @like = Like.new
    @book = Book.find(params[:book_id])
    @likes = @book.likes
  end
  def create
    @book = Book.find(params[:book_id])
    @like = @book.likes.build(like_params)
    @like.save
    respond_to do |format|
      format.html { redirect_to book_path(@book.id) }
      format.js
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @like = @book.likes.find(params[:id])
    @like.destroy
    redirect_to book_path(@book.id)
  end

  private

  def like_params
    params.require(:like).permit(:book_id, :user_id)
  end
end
