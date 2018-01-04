require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end
  describe 'NEW' do
    it 'should be successful(NEW)' do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'CREATE' do
    it 'create book(CREATE)' do
      expect do
        post :create,
             params: { book: attributes_for(:book,
                                            user_id: @user.id) }
      end.to change { Book.count }.by(1) and
        redirect_to Book.last && have_http_status(200)
    end
  end

  describe 'INDEX' do
    it 'assigns @books' do
      book = create(:book, user_id: @user.id)
      get :index
      expect(assigns(:books)).to eq([book])
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

  describe 'SHOW' do
    it 'assigns the requested book to @book' do
      book = create(:book, user_id: @user.id)
      @like = create(:like, book_id: book.id, user_id: @user.id)
      get :show, params: { id: book.id }
      expect(assigns(:book)).to eq(book)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @book = create(:book, user_id: @user.id)
    end
    context 'with good data' do
      it 'updates book' do
        put :update, params: { id: @book.id,
                               book: { name: 'xyz',
                                       author: 'asdgfas',
                                       status: 'in',
                                       img: 'asf',
                                       genre: 'asdfgva',
                                       description: 'dsgdas' } }
        expect(response).to redirect_to @book
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PUT #update_status_in' do
    before(:each) do
      @book = create(:book,
                     user_id: @user.id,
                     status: 'in')
    end
    context 'with good data' do
      it 'updates status to out' do
        put :update, params:{ id: @book.id,
                              book: { status: 'out' } }
        expect(response).to redirect_to @book
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PUT #update_status_out' do
    before(:each) do
      @book = create(:book,
                     user_id: @user.id,
                     status: 'out')
    end
    context 'with good data' do
      it 'updates status to in' do
        put :update, params: { id: @book.id,
                               book: { status: 'in' } }
        expect(response).to redirect_to @book
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the category' do
      book = create(:book, user_id: @user.id)
      expect do
        delete :destroy, params: { id: book }
      end.to change(Book, :count).by(-1)
      expect(response).to have_http_status(302)
    end

    it 'redirects to categories#index' do
      book = create(:book, user_id: @user.id)
      delete :destroy, params: { id: book }
      expect(response).to redirect_to books_url
      expect(response).to have_http_status(302)
    end
  end
end
