class BoardingRequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @canoe = Canoe.find params[:canoe_id]

    unless @canoe.member? current_user
      @boarding_request.user = current_user
      @boarding_request.canoe = @canoe
      if @boarding_request.save
        push_to_slack(@boarding_request)
      end
    end

    redirect_to @canoe
  end

  def destroy
    if @boarding_request.destroy
      push_to_slack(@boarding_request)
    end
    redirect_back fallback_location: @boarding_request.canoe
  end

  def accept
    unless @boarding_request.acceptable?
      redirect_to @boarding_request.canoe, alert: t('activerecord.errors.models.boarding_request.invalid') and return
    end

    ActiveRecord::Base.transaction do
      @boarding_request.accept
      if @boarding_request.canoe.save and @boarding_request.destroy
        push_to_slack(@boarding_request)
      end
    end
    redirect_to @boarding_request.canoe
  end
end

