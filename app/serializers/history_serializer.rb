class HistorySerializer < ActiveModel::Serializer
  attributes :id, :user, :taken_in, :returned_in, :user
  belongs_to :user
  belongs_to :book
end
