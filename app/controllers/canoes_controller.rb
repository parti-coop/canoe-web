class CanoesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @canoes = Canoe.order(:title)
  end

  def create
    # TODO current_user를 가입시켜야 합니다.
    @canoe.user = current_user
    @canoe.save

    redirect_to @canoe
  end

  private

  def canoe_params
    params.require(:canoe).permit(:title, :body, :logo)
  end
end
