class CanoesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  load_and_authorize_resource

  def index
    @canoes = Canoe.order(:title)
  end

  def show
    render layout: 'canoe'
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
    render layout: 'canoe'
  end

  def update
    @canoe = Canoe.find(params[:id])
    if @canoe.update(canoe_params)
      push_to_slack(@canoe)
      redirect_to @canoe
    else
      render 'edit'
    end
  end

  private

  def canoe_params
    params.require(:canoe).permit(:title, :body, :logo, :slack_webhook_url)
  end
end
