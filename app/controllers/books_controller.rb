class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :popular, only: :index
  before_action :find_book, only: [:show, :update, :edit, :update, :destroy]
  before_action :update_status, only: :update

  def index
    @books = Book.all.page(params[:page]).per(20)
  end

  def show
    @like = @book.likes.find_by(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.create!(book_params)
    redirect_to @book
  end

  def update
    @book.update!(book_params)
    redirect_to book_path(@book.id)
  end

  def destroy
    @book.destroy!
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :genre, :status, :img, :description, :user_id)
  end

  def update_status
    if book_params[:status] == 'out'
      History.create(user_id: current_user.id, book_id: @book.id, taken_in: DateTime.now)
    elsif book_params[:status] == 'in'
      @histories = History.where(user_id: current_user.id, returned_in: nil, book_id: @book.id)
      @histories.update(returned_in: DateTime.now) unless @histories.empty?
    end
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def popular
    @popular_books = Book.all.order_by(likes_count: :desc, histories_count: :desc)
  end
end
