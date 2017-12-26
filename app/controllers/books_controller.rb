class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :search_history, only: [:update_status]
  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.create(book_params)
    @book.save!
    redirect_to @book
  end

  def update
    @histories = History.all
    @book = Book.find(params[:id])
    @book.update!(book_params)
  end

  def update_status
    @histories = History.all
    @book = Book.find(params[:id])
      if @book.status == 'in'
        History.create(user_id: current_user.id, book_id: @book.id, taken_in: DateTime.now)
      elsif @book.status == 'out'
        @histories.each do |h|
          if h.user.id == current_user.id && h.taken_in != '' && h.returned_in == nil
            h.update(returned_in: DateTime.now)
          end
        end
      end
    @book.update(book_params)
    redirect_to @book
  end

  def show
    @histories = History.all
    @books = Book.all
    @book = Book.find(params[:id])
    @comments = Comment.where(book_id: @book.id)
    @histories = @book.histories.all
    @like = @book.likes.find_by(user_id: current_user.id)
  end

  def index
    popular
    @books = Book.all.page(params[:page]).per(20)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :genre, :status, :img, :description, :user_id)
  end

  def search_history


  end
  def popular
    @popular_books = Book.all.sort { |x,y| x.likes.count <=> y.likes.count }.reverse
  end
end
