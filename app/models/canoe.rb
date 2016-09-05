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

  def boarding_requested?(someone)
    boarding_requests.exists?(user: someone)
  end

  def receivable_boarding_request?(someone)
    !someone.blank? and
    !member?(someone) and
    !boarding_requested?(someone)
  end

  def join(someone)
    memberships.build(user: someone)
  end

  def unread?(someone)
    discussions.unread_by(someone).any?
  end
end
