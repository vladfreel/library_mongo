require 'rails_helper'
RSpec.describe Like, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to belong_to(:user).of_type(User) }
  it { is_expected.to belong_to(:book).of_type(Book) }
  it { is_expected.to validate_uniqueness_of(:user).scoped_to(:book) }
end