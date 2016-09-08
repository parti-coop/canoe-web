class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :opinion
  has_one :discussion, through: :opinion
  has_one :canoe, through: :opinion

  scope :recent, -> { order(created_at: :desc) }
end
