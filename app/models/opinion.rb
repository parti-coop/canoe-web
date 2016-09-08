class Opinion < ApplicationRecord
  include SimpleTrackable

  belongs_to :user
  belongs_to :discussion, counter_cache: true
  has_one :canoe, through: :discussion
  has_many :comments

  validates :body, presence: true
end
