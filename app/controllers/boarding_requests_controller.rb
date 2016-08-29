class BoardingRequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    # TODO 중복 가입 방지 / 기존 User가입 방지
    @boarding_request.user = current_user
    @boarding_request.canoe = Canoe.find params[:canoe_id]
    @boarding_request.save

    redirect_to @boarding_request.canoe
  end
end

