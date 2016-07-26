class Canoe < ActiveRecord::Base
  belongs_to :user
  has_many :sailing_diaries
  has_many :boarding_requests

  mount_uploader :logo, ImageUploader
end
