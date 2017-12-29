require 'rails_helper'
RSpec.describe History, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to belong_to(:user).of_type(User) }
  it { is_expected.to belong_to(:book).of_type(Book) }
  it { is_expected.to have_field(:taken_in).of_type(DateTime)}
  it { is_expected.to have_field(:returned_in).of_type(DateTime)}
  it { is_expected.to validate_presence_of(:taken_in) }
  describe '#taken_in' do
    it 'should validate presence' do
      record = History.new
      record.taken_in = ''
      record.valid?
      expect(record.errors[:taken_in]).to include("can't be blank")
      record.taken_in = DateTime.now
      record.valid?
      expect(record.errors[:taken_in]).not_to include("can't be blank")
    end
  end
end