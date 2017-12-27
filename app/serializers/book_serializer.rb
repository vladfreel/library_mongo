class BookSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :author, :genre, :description, , :url, :user, :comment_ids, :like_ids, :history_ids
  has_many :comments
  has_many :likes
  has_many :comments
  has_many :histories
  belongs_to :user
  def comment_ids
    object.comments.pluck(:id)
  end
  def like_ids
    object.likes.pluck(:id)
  end
  def history_ids
    object.histories.pluck(:id)
  end
  def url
    book_url(object)
  end

end
