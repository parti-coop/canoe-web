class ProposalRequest < ApplicationRecord
  include HistoricalTrackable

  belongs_to :user
  belongs_to :discussion
  has_many :proposals, dependent: :destroy
  has_one :canoe, through: :discussion

  scope :archived, -> { where.not(archived_at: nil) }
  scope :inboxed, -> { where(archived_at: nil) }

  def best? proposal
    proposals.maximum(:agree_votes_count) == proposal.agree_votes_count and proposals.minimum(:agree_votes_count) != proposal.agree_votes_count
  end

  def danger? proposal
    proposals.maximum(:block_votes_count) == proposal.block_votes_count and proposals.minimum(:block_votes_count) != proposal.block_votes_count
  end

  def archive
    self.archived_at = current_time_from_proper_timezone
  end

  def inbox
    self.archived_at = nil
  end

  def archived?
    archived_at.present?
  end

  def inboxed?
    !archived?
  end
end
