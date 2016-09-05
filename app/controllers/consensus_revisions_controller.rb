class ConsensusRevisionsController < ApplicationController
  load_and_authorize_resource :discussion
  load_and_authorize_resource through: :discussion, shallow: true
  before_action :discussion_canoe
  before_action :fetch_canoe

  layout 'canoe'

  private

  def fetch_canoe
    return @canoe if @canoe.present?
    return @canoe = @discussion.canoe if @discussion.present?
    return @canoe = @consensus_revision.canoe if @consensus_revision.present?
  end

  def discussion_canoe
    return @discussion if @discussion.present?
    return @discussion = @consensus_revision.discussion if @consensus_revision.present?
  end
end
