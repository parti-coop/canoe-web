class ProposalRequest < ApplicationRecord
  include Trackable

  belongs_to :user
  belongs_to :discussion
  has_many :proposals, dependent: :destroy
  has_one :canoe, through: :discussion
end
