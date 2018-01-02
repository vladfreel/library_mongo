# Histories
class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_book, only: [:create, :update]

  def create
    @history = @book.histories.create!(history_params)
    redirect_to book_path(@book.id)
  end

  def update
    @history = History.find(params[:id])
    @history.update(history_params)
    redirect_to book_path(@book.id)
  end

  private

  def history_params
    params.require(:history).permit(:user_id, :book_id, :taken_in, :returned_in)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end
end
