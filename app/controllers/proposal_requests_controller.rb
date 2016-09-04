class ProposalRequestsController < ApplicationController
  load_and_authorize_resource :discussion
  load_and_authorize_resource through: :discussion, shallow: true

  def create
    @discussion = find_discussion
    @proposal_request = @discussion.proposal_requests.build(proposal_request_params)
    @proposal_request.user = current_user
    @proposal_request.track(self)
    @proposal_request.save
    redirect_back fallback_location: @discussion
  end

  private

  def find_discussion
    Discussion.find(params[:discussion_id])
  end

  def proposal_request_params
    params.require(:proposal_request).permit(:title)
  end
end
