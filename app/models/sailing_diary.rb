class SailingDiary < ApplicationRecord
  belongs_to :user
  belongs_to :canoe

  scope :recent, -> { order(created_at: :desc) }
end
