class MembershipsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @canoe = Canoe.find(params[:canoe_id])
    @memberships = @canoe.memberships
    @boarding_requests = @canoe.boarding_requests
  end
end