# Like
class Like
  include Mongoid::Document
  belongs_to :book, counter_cache: :likes_count
  belongs_to :user
  validates :user, uniqueness: { scope: :book }

end
