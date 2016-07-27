class DiscussionsController < ApplicationController
  before_filter :load_canoe
  load_and_authorize_resource

  def index
    @discussions = @canoe.discussions.order("id DESC")
  end

  def create
    @discussion.canoe = @canoe
    @discussion.user = current_user
    @discussion.save

    redirect_to canoe_discussions_path(@canoe)
  end

  def edit
  end

  def update
    if @discussion.update_attributes(discussion_params)
      redirect_to canoe_discussions_path(@canoe)
    else
      render 'edit'
    end
  end

  def destroy
    @discussion.destroy
    redirect_to canoe_discussions_path(@canoe)
  end

  private

  def load_canoe
    @canoe = Canoe.find(params[:canoe_id])
  end

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end
end