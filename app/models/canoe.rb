class Canoe < ApplicationRecord
  belongs_to :user
  has_many :discussions
  has_many :wikis
  has_many :sailing_diaries do
    def today(someone)
      find_by(sailed_on: Date.current, user: someone)
    end
  end
  has_many :boarding_requests, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :categories, dependent: :destroy do
    def base
      find_by name: Category::DEFAULT_NAME
    end

    def persisted
      select{ |category| category.persisted? }
    end
  end

  mount_uploader :logo, ImageUploader

  after_create do |document|
    document.categories.create(name: Category::DEFAULT_NAME, user: document.user)
  end

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
    someone.present? and discussions.unread_by(someone).any?
  end
end
