class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
    @book = Book.new
  end
  def edit
    @book = Book.find(params[:id])
  end
  def create
    @book = Book.new(book_params)
    @book.save!
    redirect_to @book
  end
  def update
    @histories = History.all
    @book = Book.find(params[:id])
    if @book.update(book_params)
      if @book.status == 'out'
        search_history_in
      elsif @book.status == 'in'
        search_history_out
      end
      redirect_to @book
    else
      render 'edit'
    end
  end
  def show
    @histories = History.all
    @books = Book.all
    @book = Book.find(params[:id])
    @comments = Comment.where(book_id: @book.id)
    @histories = @book.histories.all
    @like = @book.likes.find_by(user_id: current_user.id) rescue nil
    if !@like.nil?

    else

    end
  end

  def index
    @books = Book.all.page(params[:page]).per(20)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :status, :img, :description, :user_id, tags_attributes: [:user_id, :id, :taken_in, :returned_in])
  end
  def search_history_in
    History.create(user_id: current_user.id, book_id: @book.id, taken_in: DateTime.now)
  end
  def search_history_out
  @histories.each do |h|
    if h.user_id == current_user.id && h.taken_in != ''
      if h.returned_in != nil
      else
        History.update(returned_in: DateTime.now)
    end
    elsif h.user_id == current_user.id && h.taken_in != '' && h.returned_in != nil
    elsif h.user_id == current_user.id
    else
      History.create(user_id: current_user.id, book_id: @book.id, taken_in: DateTime.now)
    end
  end
  end
  def popular
    @out = Book.select('books.*,
    COUNT(likes.id) AS t_count').joins(:likes).group('
    books.id').order('t_count DESC').limit(5)
  end
end
