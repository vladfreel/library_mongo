require 'rails_helper'
describe 'add like to book' do
  let(:user) { FactoryBot.create(:user) }
  it 'should add book', js: true do
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'pass', with: user.password
    click_button 'Sign in'
    click_on('Добавить книгу')
    fill_in 'book_name', with: 'книга'
    fill_in 'book_genre', with: 'жанр книги'
    fill_in 'book_author', with: 'автор книги'
    attach_file('book[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    fill_in 'book_description', with: 'описание книги'
    click_on('Create Book')
    expect(Book.count).to eq(1)
    book = Book.last.id
    expect(current_path) == book_path(id: book)
    click_on('Взять')
    expect(History.count).to eq(1)
    click_on('Вернуть')
    expect(History.last.returned_in).not_to eq(nil)
  end
end