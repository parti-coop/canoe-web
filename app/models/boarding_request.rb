class BoardingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :canoe

  validates :user, presence: true, uniqueness: {scope: :canoe}
end
