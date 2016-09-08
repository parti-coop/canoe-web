class Vote < ApplicationRecord
  include HistoricalTrackable

  belongs_to :user
  belongs_to :proposal
  counter_culture :proposal, column_name: proc {|vote| "#{vote.choice}_votes_count" }
  has_one :discussion, through: :proposal
  has_one :canoe, through: :proposal

  validates :choice, presence: true
  validates :user, uniqueness: { scope: :proposal }

  extend Enumerize
  enumerize :choice, in: [:agree, :block]
end
