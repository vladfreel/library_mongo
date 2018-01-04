require 'rails_helper'
describe 'add book' do
  let(:user) { FactoryBot.create(:user) }
  it 'should edit book', js: true do
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
    find('#drop').click
    click_on('Изменить')
    expect(current_path) == edit_book_path(id: book)
    fill_in 'book_name', with: 'книга2'
    click_on('Update Book')
    expect(current_path) == book_path(id: book)
    expect(page).to have_content('книга2')
  end
end
