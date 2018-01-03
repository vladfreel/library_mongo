require 'rails_helper'
describe 'add book' do
  let(:user) { FactoryBot.create(:user) }
  it 'should sign in', js: true do
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'pass', with: user.password
    click_button 'Sign in'
    expect(current_path) == books_path
  end
end