require 'rails_helper'
RSpec.describe 'routes for Comments', type: :routing do

  it do
    should route(:get,
                 '/books/1/comments/new').to('comments#new', action: :new, book_id: 1)
  end
  it do
    should route(:post,
                 '/books/1/comments').to('comments#create', action: :create, book_id: 1)
  end
end
