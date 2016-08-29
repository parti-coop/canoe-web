class BoardingRequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @canoe = Canoe.find params[:canoe_id]

    unless @canoe.member? current_user
      @boarding_request.user = current_user
      @boarding_request.canoe = @canoe
      @boarding_request.save
    end

    redirect_to @canoe
  end
end

