class BoardingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :canoe
end
