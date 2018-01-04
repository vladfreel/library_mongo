require 'rails_helper'
RSpec.describe HistoriesController, type: :controller do
  before(:each) do
    @user = create(:user)
    @book = create(:book, user_id: @user.id)
    sign_in @user
  end

  describe 'CREATE' do
    it 'create history(CREATE)' do
      expect do
        post :create,
             params: { history: attributes_for(:history,
                                               returned_in: '',
                                               user_id: @user.id),
                       book_id: @book.id }
      end.to change { History.count }.by(1) and have_http_status(200)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @history = create(:history,
                        taken_in: DateTime.now,
                        returned_in: '',
                        user_id: @user.id,
                        book_id: @book.id)
    end
    context 'with good data' do
      it 'updates book' do
        put :update,
            params: { id: @history.id,
                      history: { returned_in: DateTime.now },
                      book_id: @book.id,
                      user_id: @user.id }
        expect(response).to redirect_to @book
        expect(response).to have_http_status(302)
      end
    end
  end
end
