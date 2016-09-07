class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :opinion
  has_one :discussion, through: :opinion
  has_one :canoe, through: :opinion

  after_create :update_activity
  after_create :stroke_discussion

  scope :recent, -> { order(created_at: :desc) }

  private

  def update_activity
    self.opinion.activity.touch
  end

  def stroke_discussion
    self.discussion.stroke
  end
end
