require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = create(:user)
    @book = create(:book, user_id: @user.id)
    sign_in @user
  end

  describe 'CREATE' do
    it 'create comment(CREATE)' do
      expect do
        post :create,
             params: { comment: attributes_for(:comment, body: "asgas", user_id: @user.id),
                       book_id: @book.id }
      end.to change { Comment.count }.by(1) and have_http_status(200)
    end
  end
end
