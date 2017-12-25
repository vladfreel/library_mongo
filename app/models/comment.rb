class Comment
  include Mongoid::Document
  field :body, type: String
  belongs_to :book
  belongs_to :user
  validates :body, presence: true
end
