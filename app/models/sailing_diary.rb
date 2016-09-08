class SailingDiary < ApplicationRecord
  belongs_to :user
  belongs_to :canoe
  has_many :comments, as: :commentable

  scope :recent, -> { order(created_at: :desc) }

  def model_for_show
    canoe
  end
end
