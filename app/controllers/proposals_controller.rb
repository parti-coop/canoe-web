class ProposalsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user = current_user
    @proposal.track(self)
    if @proposal.save
      push_to_slack(@proposal)
    end
    redirect_back fallback_location: @discussion
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    if @proposal.destroy
      push_to_slack(@proposal)
    end
    redirect_back fallback_location: @discussion
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :proposal_request_id)
  end
end
