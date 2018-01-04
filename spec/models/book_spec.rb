require 'rails_helper'
RSpec.describe Book, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:author).of_type(String) }
  it { is_expected.to have_field(:status).of_type(String) }
  it { is_expected.to have_field(:genre).of_type(String) }
  it { is_expected.to have_field(:img).of_type(String) }
  it { is_expected.to have_field(:description).of_type(String) }
  it { is_expected.to belong_to(:user).of_type(User).with_foreign_key(:user_id) }
  it { is_expected.to have_many(:comments).with_dependent(:destroy) }
  it { is_expected.to have_many(:likes).with_dependent(:destroy) }
  it { is_expected.to have_many(:histories).with_dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:genre) }
  it { is_expected.to validate_presence_of(:description) }
  describe '#name' do
    it 'should validate presence' do
      record = Book.new
      record.name = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:name]).to include("can't be blank")
      record.name = 'cars' # valid state
      record.valid? # run validations
      expect(record.errors[:name]).not_to include("can't be blank")
    end
  end
  describe '#author' do
    it 'should validate presence' do
      record = Book.new
      record.author = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:author]).to include("can't be blank")
      record.author = 'cars' # valid state
      record.valid? # run validations
      expect(record.errors[:author]).not_to include("can't be blank")
    end
  end
  describe '#genre' do
    it 'should validate presence' do
      record = Book.new
      record.genre = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:genre]).to include("can't be blank")
      record.genre = 'cars' # valid state
      record.valid? # run validations
      expect(record.errors[:genre]).not_to include("can't be blank")
    end
  end
  describe '#description' do
    it 'should validate presence' do
      record = Book.new
      record.description = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:description]).to include("can't be blank")
      record.description = 'cars' # valid state
      record.valid? # run validations
      expect(record.errors[:description]).not_to include("can't be blank")
    end
  end
end
