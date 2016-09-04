class Opinion < ApplicationRecord
  include Trackable

  belongs_to :user
  belongs_to :discussion, counter_cache: true
  has_one :canoe, through: :discussion

  default_scope { order("created_at ASC") }

  validates :body, presence: true
end
