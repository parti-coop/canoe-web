class VotesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: Proposal, instance_name: :proposal

  def agree
    vote(:agree)
  end

  def block
    vote(:block)
  end

  def destroy
    @vote = @proposal.vote_of(current_user)
    if @vote.present? and @vote.destroy
      @vote.track(self)
      push_to_slack(@vote)
    end
    redirect_back fallback_location: @proposal.canoe
  end

  private

  def vote(choice)
    if @proposal.voted_by? current_user
      @vote = @proposal.vote_of(current_user)
      @vote.choice = choice
    else
      @vote = @proposal.votes.build(choice: choice, user: current_user)
    end
    @vote.track(self) if @vote.changed? or @vote.new_record?
    if @vote.save
      push_to_slack(@vote)
    end
    redirect_back fallback_location: @proposal.canoe
  end
end

