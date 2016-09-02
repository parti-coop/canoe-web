class ProposalRequestsController < ApplicationController
  load_and_authorize_resource

  def create
    @discussion = find_discussion
    @proposal_request = @discussion.proposal_requests.build(proposal_request_params)
    @proposal_request.user = current_user
    @proposal_request.save
    redirect_to :back
  end

  private

  def find_discussion
    Discussion.find(params[:discussion_id])
  end

  def proposal_request_params
    params.require(:proposal_request).permit(:title)
  end
end