# Histories
class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @history = @book.histories.new(history_params)
    @history.save!
    redirect_to book_path(@book.id)
  end

  def update
    @book = Book.find(params[:book_id])
    @history = History.find(params[:id])
    @history.update(history_params)
    redirect_to book_path(@book.id)
  end

  private

  def history_params
    params.require(:history).permit(:user_id, :book_id, :taken_in, :returned_in)
  end
end
