require 'active_support/concern'

module Trackable
  extend ActiveSupport::Concern

  included do
    has_many :activities, as: :trackable, dependent: :destroy
  end

  def track(actor)
    action = "#{actor.controller_name}/#{actor.action_name}"
    activities.build(user: self.user, discussion: self.discussion, action: action)
  end
end
