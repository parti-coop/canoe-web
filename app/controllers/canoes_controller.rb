class CanoesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  load_and_authorize_resource

  def index
    @canoes = Canoe.order(:title)
  end

  def new
    @canoe = Canoe.new
  end

  def create
    @canoe.user = current_user
    @canoe.join(current_user)
    @canoe.save

    redirect_to @canoe
  end

  def edit
    @canoe = Canoe.find(params[:id])
  end

  def update
    @canoe = Canoe.find(params[:id])
    if @canoe.update(canoe_params)
      redirect_to @canoe
    else
      render 'update'
    end
  end

  private

  def canoe_params
    params.require(:canoe).permit(:title, :body, :logo)
  end
end
