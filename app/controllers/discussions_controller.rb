class DiscussionsController < ApplicationController
  load_and_authorize_resource :canoe
  load_and_authorize_resource through: :canoe, shallow: true

  layout 'canoe'

  def index
    @discussions = @canoe.discussions.order("id DESC")
  end

  def show
    @dicussion = Discussion.find(params[:id])
    @canoe = @discussion.canoe
  end

  def create
    @discussion.canoe = @canoe
    @discussion.user = current_user
    @discussion.save

    redirect_to @discussion || @canoe
  end

  def edit
    @canoe = @discussion.canoe
  end

  def update
    if @discussion.update_attributes(discussion_params)
      redirect_to @discussion
    else
      render 'edit'
    end
  end

  def destroy
    @discussion.destroy
    redirect_to @canoe
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end
end
