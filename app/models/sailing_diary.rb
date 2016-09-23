class SailingDiary < ApplicationRecord
  belongs_to :user
  belongs_to :canoe
  has_many :comments, as: :commentable, dependent: :destroy

  scope :recent, -> { order(sailed_on: :desc, id: :desc) }

  def model_for_show
    canoe
  end
end
