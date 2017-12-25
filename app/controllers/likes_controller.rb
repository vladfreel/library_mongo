class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    @like = @book.likes.new(like_params)
    @like.save!
    redirect_to book_path(@book.id)
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
