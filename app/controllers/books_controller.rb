class BooksController < ApplicationController
  before_action :authenticate_user!
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
    redirect_to book_path(@book.id)
  end

  def update_status_in
    @histories = History.all
    @book = Book.find(params[:id])
    History.create(user_id: current_user.id, book_id: @book.id, taken_in: DateTime.now)
    @book.update(book_params)
    respond_to do |format|
      format.html { redirect_to book_path(@book.id) }
      format.js
    end
  end

  def update_status_out
    @histories = History.all
    @book = Book.find(params[:id])
    @histories.each do |h|
      if h.user.id == current_user.id && h.taken_in != '' && h.returned_in == nil
        h.update(returned_in: DateTime.now)
      end
    end
    @book.update(book_params)
    respond_to do |format|
      format.html { redirect_to book_path(@book.id) }
      format.js
    end
  end

  def show
    @histories = History.all
    @books = Book.all
    @book = Book.find(params[:id])
    @comments = Comment.where(book_id: @book.id)
    @histories = @book.histories.all
    @like = @book.likes.find_by(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
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

  def popular
    @popular_books = Book.all.sort { |x,y| x.likes.count <=> y.likes.count; x.histories.count <=> y.histories.count;}.reverse
  end
end
