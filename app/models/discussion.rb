class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :canoe
  has_many :opinions, dependent: :destroy
  has_many :proposal_requests, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
end
