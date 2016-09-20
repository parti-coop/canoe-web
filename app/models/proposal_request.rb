class ProposalRequest < ApplicationRecord
  include HistoricalTrackable

  belongs_to :user
  belongs_to :discussion
  has_many :proposals, dependent: :destroy
  has_one :canoe, through: :discussion

  def best? proposal
    proposals.maximum(:agree_votes_count) == proposal.agree_votes_count and proposals.minimum(:agree_votes_count) != proposal.agree_votes_count
  end

  def danger? proposal
    proposals.maximum(:block_votes_count) == proposal.block_votes_count and proposals.minimum(:block_votes_count) != proposal.block_votes_count
  end
end
