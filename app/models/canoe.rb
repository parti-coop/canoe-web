class Canoe < ActiveRecord::Base
  belongs_to :user
  has_many :boarding_requests

  mount_uploader :logo, ImageUploader
end
