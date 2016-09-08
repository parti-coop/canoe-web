class Proposal < ApplicationRecord
  include HistoricalTrackable

  belongs_to :user
  belongs_to :proposal_request
  has_one :discussion, through: :proposal_request
  has_one :canoe, through: :proposal_request
  has_many :votes, dependent: :destroy
  has_many :agree_votes, -> { where choice: :agree }, class_name: 'Vote'
  has_many :agreeing_users, through: :agree_votes, class_name: 'User', :source => :proposal
  has_many :block_votes, -> { where choice: :block }, class_name: 'Vote'
  has_many :blocking_users, through: :block_votes, class_name: 'User', :source => :proposal

  def agreed_by? someone
    votes.exists? user: someone, choice: :agree
  end

  def blocked_by? someone
    votes.exists? user: someone, choice: :block
  end

  def voted_by? someone
    votes.exists? user: someone
  end

  def vote_of someone
    votes.find_by(user: someone)
  end
end
