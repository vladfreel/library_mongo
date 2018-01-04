require 'rails_helper'
describe 'add book' do
  let(:user) { FactoryBot.create(:user) }
  it 'should sign up', js: true do
    visit new_user_registration_path
    fill_in 'email_s', with: Faker::Internet.email
    fill_in 'pass_s', with: 'password'
    fill_in 'conf_pass_s', with: 'password'
    click_button 'Sign up'
    expect(User.count).to eq(1)
    expect(current_path) == books_path

  end
end
