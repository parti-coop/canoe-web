class DiscussionsController < ApplicationController
  load_and_authorize_resource

  def index
    @canoe = find_canoe
    @discussions = @canoe.discussions.order("id DESC")
  end

  def show
    @dicussion = Discussion.find(params[:id])
    @canoe = @discussion.canoe
  end

  def new
    @canoe = find_canoe
  end

  def create
    @canoe = find_canoe
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

  def find_canoe
    @canoe = Canoe.find(params[:canoe_id])
  end

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end
end