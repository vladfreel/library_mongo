# require 'rails_helper'
# RSpec.describe 'Book management', type: :request do
#   it 'creates a Category and redirects to the Category page' do
#     @user = create(:user)
#     sign_in @user
#     get '/books/new'
#     expect(response).to render_template(:new)
#     post '/books', params: { book: { user_id: @user.id } }
#     expect(response).to redirect_to(assigns(:book))
#     follow_redirect!
#     expect(response).to render_template(:show)
#     expect(response.body).to include(Book.last.name)
#   end
#
#   it 'does not render a different template' do
#     @user = create(:user)
#     sign_in @user
#     get '/books/new'
#     expect(response).to_not render_template(:show)
#   end
#
# end
#
#
