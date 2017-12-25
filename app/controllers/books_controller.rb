
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
    popular
    @exp = [@first_book, @second_book, @third_book, @fourth_book, @fifth_book]
    @books = Book.all.page(params[:page]).per(20)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :genre, :status, :img, :description, :user_id, tags_attributes: [:user_id, :id, :taken_in, :returned_in])
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

    @first_book = Book.first
    @second_book = Book.first
    @third_book = Book.first
    @fourth_book = Book.first
    @fifth_book = Book.first

    @popular_books = Book.all
    @popular_books.each do |book1|
      if book1.likes.count >= @first_book.likes.count
        @first_book = book1
        end
    end

    @popular_books.each do |book2|
      if book2 == @first_book
      else
        book2.likes.count
        if book2.likes.count >= @second_book.likes.count
          @second_book = book2
        end
      end
    end

    @popular_books.each do |book3|
      if book3 == @second_book || book3 == @first_book
      else
        book3.likes.count
        if book3.likes.count >= @third_book.likes.count
          @third_book = book3
        end
      end
    end

    @popular_books.each do |book4|
      if book4 == @third_book || book4 == @second_book || book4 == @first_book
      else
        book4.likes.count
        if book4.likes.count >= @fourth_book.likes.count
          @fourth_book = book4
        end
      end
    end

    @popular_books.each do |book5|
      if book5 == @fourth_book || book5 == @third_book || book5 == @second_book || book5 == @first_book
      else
        book5.likes.count
        if book5.likes.count >= @fifth_book.likes.count
          @fifth_book = book5
        end
      end
    end
  end
end
