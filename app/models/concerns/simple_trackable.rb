require 'active_support/concern'

module SimpleTrackable
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :trackable, dependent: :destroy
  end

  def track
    if activity.blank?
      self.build_activity(user: self.user, discussion: self.discussion, action: self.class.name.underscore)
    else
      activity.update_attributes(updated_at: current_time_from_proper_timezone)
    end
    stroke_discussion
  end

  def stroke_discussion
    self.discussion.stroke
  end
end
