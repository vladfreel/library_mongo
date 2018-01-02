# Book
class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Letsrate
  letsrate_rateable

  attr_accessor :img
  mount_uploader :img, ImgUploader

  field :name, type: String
  field :status, type: String
  field :author, type: String
  field :genre, type: String
  field :img, type: String
  field :description, type: String
  field :likes_count, type: Integer
  field :histories_count, type: Integer

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: :user_id



  validates :name, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :description, presence: true
end
