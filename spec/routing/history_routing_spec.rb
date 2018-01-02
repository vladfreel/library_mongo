require 'rails_helper'
RSpec.describe 'routes for Histories', type: :routing do
  it do
    should route(:get, '/books/1/histories/new').to('histories#new', action: :new, book_id: 1)
  end
  it do
    should route(:post, '/books/1/histories').to('histories#create', action: :create, book_id: 1)
  end
  it do
    expect(put: '/books/1/histories/1').to route_to(controller: 'histories', action: 'update', book_id: '1', id: '1')
  end
end
