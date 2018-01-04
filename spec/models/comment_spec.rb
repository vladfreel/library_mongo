require 'rails_helper'
RSpec.describe Comment, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:body).of_type(String) }
  it { is_expected.to belong_to(:user).of_type(User) }
  it { is_expected.to belong_to(:book).of_type(Book) }
  describe '#body' do
    it 'should validate presence' do
      record = Comment.new
      record.body = ''
      record.valid?
      expect(record.errors[:body]).to include("can't be blank")
      record.body = 'cars'
      record.valid?
      expect(record.errors[:body]).not_to include("can't be blank")
    end
  end
end
