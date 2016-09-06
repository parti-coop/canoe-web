class Category < ApplicationRecord
  belongs_to :canoe
  belongs_to :user
  has_many :discussions

  DEFAULT_NAME = '기본'

  def unread?(someone)
    someone.present? and discussions.unread_by(someone).any?
  end
end
