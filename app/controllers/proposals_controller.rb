class ProposalsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  layout 'canoe'

  def create
    @proposal.user = current_user
    @proposal.track(self)
    if @proposal.save
      push_to_slack(@proposal)
    end
    redirect_back fallback_location: @discussion
  end

  def destroy
    if @proposal.destroy
      push_to_slack(@proposal)
    end
    redirect_back fallback_location: @discussion
  end

  def edit
    @canoe = @proposal.canoe
    @discussion = @proposal.discussion
  end

  def update
    @proposal.assign_attributes(update_params)
    @proposal.track(self)
    if @proposal.save
      push_to_slack(@proposal)
    end
    redirect_to @proposal.discussion
  end

  private

  def create_params
    params.require(:proposal).permit(:title, :proposal_request_id)
  end

  def update_params
    params.require(:proposal).permit(:title)
  end
end
