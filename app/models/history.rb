# History
class History
  include Mongoid::Document
  belongs_to :book, counter_cache: :histories_count
  belongs_to :user
  field :taken_in, type: DateTime
  field :returned_in, type: DateTime
  validates :taken_in, presence: true
end
