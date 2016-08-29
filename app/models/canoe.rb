class Canoe < ApplicationRecord
  belongs_to :user
  has_many :discussions
  has_many :sailing_diaries
  has_many :boarding_requests
  has_many :memberships, dependent: :destroy

  mount_uploader :logo, ImageUploader

  def member?(someone)
    memberships.exists?(user: someone)
  end
end
