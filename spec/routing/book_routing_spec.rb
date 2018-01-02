require 'rails_helper'
RSpec.describe 'routes for Books', type: :routing do
  it do
    expect(get: '/books').to route_to(controller: 'books', action: 'index')
  end

  it do
    expect(get: '/books/1').to route_to(controller: 'books', action: 'show', id: '1')
  end

  it do
    expect(put: '/books/1').to route_to(controller: 'books', action: 'update', id: '1')
  end

  it do
    expect(get: '/books/new').to route_to(controller: 'books', action: 'new')
  end

  it do
    expect(post: '/books').to route_to(controller: 'books', action: 'create')
  end

  it do
    expect(delete: '/books/1').to route_to(controller: 'books', action: 'destroy', id: '1')
  end
end
