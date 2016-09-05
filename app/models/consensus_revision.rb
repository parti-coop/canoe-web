class ConsensusRevision < ApplicationRecord
  include Trackable

  belongs_to :discussion
  has_one :canoe, through: :discussion
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def previous_version
    previous(field: :id, scope: ->(record){ where(discussion: record.discussion) })
  end
end
