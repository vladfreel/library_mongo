# History
class History
  include Mongoid::Document
  belongs_to :book
  belongs_to :user
  field :taken_in, type: DateTime
  field :returned_in, type: DateTime
end
