class ProposalRequest < ApplicationRecord
  belongs_to :user
  belongs_to :discussion
  has_many :proposals, dependent: :destroy
end
