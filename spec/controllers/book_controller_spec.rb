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
                                                user_id: @user) }
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
    it 'assigns the requested category to @category' do
      book = create(:book, user_id: @user.id)
      get :show, params: { id: book.id }
      expect(assigns(:book)).to eq(book)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the category' do
      book = create(:book, user_id: @user.id)
      expect do
        delete :destroy, params: { id: book }
      end.to change(Category, :count).by(-1)
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
