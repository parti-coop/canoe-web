class CanoesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  load_and_authorize_resource

  def index
    @canoes = Canoe.order(:title)
  end

  def create
    @canoe.user = current_user
    @canoe.join(current_user)
    @canoe.save

    redirect_to @canoe
  end

  private

  def canoe_params
    params.require(:canoe).permit(:title, :body, :logo)
  end
end
