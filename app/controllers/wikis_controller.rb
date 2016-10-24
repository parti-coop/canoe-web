class WikisController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :canoe, parent: true, parent_action: :member
  load_and_authorize_resource through: :canoe, shallow: true

  layout 'canoe'

  def index
    @wikis = @canoe.wikis
  end

  def show
    @canoe = @wiki.canoe
  end

  def new
  end

  def create
    @wiki.canoe = @canoe
    if @wiki.save
      push_to_slack(@wiki)
    end

    redirect_to @wiki || @canoe
  end

  def edit
    @canoe = @wiki.canoe
  end

  def update
    if @wiki.update(wiki_params)
      push_to_slack(@wiki)
      redirect_to @wiki
    else
      render 'edit'
    end
  end

  def destroy
    if @wiki.destroy
      push_to_slack(@wiki)
    end
    redirect_to canoe_wikis_path(@canoe)
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
