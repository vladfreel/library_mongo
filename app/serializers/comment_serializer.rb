class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :body, :user
  belongs_to :user
  belongs_to :book
end
