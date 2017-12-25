class Book
  include Mongoid::Document
  field :name, type: String
  field :status, type: String
  field :author, type: String
  field :genre, type: String
  field :img, type: String
  field :description, type: String
  belongs_to :user
  attr_accessor :img
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  accepts_nested_attributes_for :histories
  mount_uploader :img, ImgUploader
  validates :name, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :description, presence: true
end
