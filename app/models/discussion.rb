class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :canoe
  has_many :opinions
end
