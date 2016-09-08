class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  scope :recent, -> { order(created_at: :desc) }

  def canoe
    commentable.canoe
  end
end
