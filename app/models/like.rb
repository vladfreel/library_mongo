# Like
class Like
  include Mongoid::Document
  belongs_to :book
  belongs_to :user
  validates :user, uniqueness: { scope: :book }
end
