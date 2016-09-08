class Opinion < ApplicationRecord
  include SimpleTrackable

  belongs_to :user
  belongs_to :discussion, counter_cache: true
  has_one :canoe, through: :discussion
  has_many :comments, as: :commentable

  validates :body, presence: true

  def mode_for_show
    discussion
  end
end
