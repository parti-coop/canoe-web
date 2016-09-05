class DiscussionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource :canoe
  load_and_authorize_resource through: :canoe, shallow: true

  layout 'canoe'

  def index
    @discussions = @canoe.discussions.order("id DESC")
  end

  def show
    @canoe = @discussion.canoe
    @discussion.mark_as_read! for: current_user if user_signed_in?
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

  def consensus
    @discussion.assign_attributes(params.require(:discussion).permit(:consensus))
    @consensus_revision = @discussion.consensus_revisions.build(user: current_user, body: @discussion.consensus)
    @consensus_revision.track(self)
    if @discussion.consensus_changed? and @discussion.save
      redirect_to @discussion
    else
      @canoe = @discussion.canoe
      render 'edit_consensus'
    end
  end

  def edit_consensus
    @canoe = @discussion.canoe
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
