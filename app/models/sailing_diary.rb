class SailingDiary < ApplicationRecord
  belongs_to :user
  belongs_to :canoe
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :emotions

  scope :recent, -> { order(sailed_on: :desc, id: :desc) }
  scope :with_emotion, ->(sign) { joins(:emotions).where('emotions.sign': sign) }

  def model_for_show
    canoe
  end

  def build_emotions
    scanned_emotions = Emotion.scan(self.body)
    self.emotions.select { |e| !scanned_emotions.include? e }.each { |e| e.delete }
    self.emotions << scanned_emotions.select { |e| !self.emotions.exists?(e.id) }
  end

  def scan_mentioned_congressmen(comment)
    parse_mention_sign(comment.body).map { |name| Congressman.find_by(name: name) }.compact
  end
end
