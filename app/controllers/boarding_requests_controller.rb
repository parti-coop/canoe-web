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

  def destroy
    @boarding_request.destroy
    redirect_back fallback_location: @boarding_request.canoe
  end

  def accept
    unless @boarding_request.acceptable?
      redirect_to @boarding_request.canoe, alert: t('activerecord.errors.models.boarding_request.invalid') and return
    end

    ActiveRecord::Base.transaction do
      @boarding_request.accept
      if @boarding_request.canoe.save
        @boarding_request.destroy
      end
    end
    redirect_to @boarding_request.canoe
  end
end

