class MembershipsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :canoe, parent: true, parent_action: :member
  load_and_authorize_resource through: :canoe, shallow: true

  layout 'canoe'

  def index
    @memberships = @canoe.memberships
    @boarding_requests = @canoe.boarding_requests
  end

  def cancel
    @membership = @canoe.memberships.find_by user: current_user
    @membership.try(:destroy)
    redirect_to @canoe
  end
end
