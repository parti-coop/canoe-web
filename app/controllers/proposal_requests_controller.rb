class ProposalRequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :discussion
  load_and_authorize_resource through: :discussion, shallow: true

  def create
    @discussion = find_discussion
    @proposal_request = @discussion.proposal_requests.build(proposal_request_params)
    @proposal_request.user = current_user
    @proposal_request.track(self)
    if @proposal_request.save
      push_to_slack(@proposal_request)
    end
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
