class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  belongs_to :discussion

  scope :recent, -> { order(updated_at: :desc).order(created_at: :desc) }
end
