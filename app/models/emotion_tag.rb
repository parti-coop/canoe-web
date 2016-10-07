class EmotionTag < ApplicationRecord
  belongs_to :sailing_diary
  belongs_to :emotion
end
