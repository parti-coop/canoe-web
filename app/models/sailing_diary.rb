class SailingDiary < ApplicationRecord
  belongs_to :user
  belongs_to :canoe
end
