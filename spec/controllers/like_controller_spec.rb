require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before(:each) do
    @user = create(:user)
    @book = create(:book, user_id: @user.id)
    sign_in @user
  end

  describe 'CREATE' do
    it 'create comment(CREATE)' do
      expect do
        post :create,
             params: { like: attributes_for(:like,
                                            user_id: @user.id),
                       book_id: @book.id }
      end.to change { Like.count }.by(1) and have_http_status(200)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the like' do
      like = create(:like,
                    user_id: @user.id,
                    book_id: @book.id)
      expect do
        delete :destroy, params: { book_id: @book.id, id: like }
      end.to change(Like, :count).by(-1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to book_path(@book.id)
      expect(response).to have_http_status(302)
    end
  end
end
