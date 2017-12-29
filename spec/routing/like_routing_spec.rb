require 'rails_helper'
RSpec.describe 'routes for Likes', type: :routing do
  it do
    should route(:get, '/books/1/likes/new').to('likes#new', action: :new, book_id: 1)
  end
  it do
    should route(:post, '/books/1/likes').to('likes#create', action: :create, book_id: 1)
  end
end
