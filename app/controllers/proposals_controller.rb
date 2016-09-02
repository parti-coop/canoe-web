class ProposalsController < ApplicationController
  load_and_authorize_resource

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user = current_user
    @proposal.save
    redirect_to :back
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    redirect_to :back
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :proposal_request_id)
  end
end