class Proposal < ApplicationRecord
  belongs_to :user
  belongs_to :proposal_request
end
