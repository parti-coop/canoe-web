class Vote < ApplicationRecord
  belongs_to :proposal
  counter_culture :proposal, column_name: proc {|vote| "#{vote.choice}_votes_count" }
  belongs_to :user
  has_one :canoe, through: :proposal

  validates :choice, presence: true
  validates :user, uniqueness: { scope: :proposal }

  extend Enumerize
  enumerize :choice, in: [:agree, :block]
end
