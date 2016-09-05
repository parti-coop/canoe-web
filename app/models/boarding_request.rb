class BoardingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :canoe, counter_cache: true

  validates :user, presence: true, uniqueness: {scope: :canoe}

  scope :recent, -> { order(created_at: :desc) }

  def acceptable?
    !canoe.member?(user)
  end

  def accept
    canoe.join(user)
  end
end
