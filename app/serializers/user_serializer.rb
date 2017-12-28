# UserSerializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :books
  has_many :histories
  has_many :likes
  has_many :comments
end
