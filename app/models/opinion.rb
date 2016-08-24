class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion, counter_cache: true
  has_one :canoe, through: :discussion

  default_scope { order("created_at DESC") }

  validates :body, presence: true
end