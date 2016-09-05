class OpinionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :discussion
  load_and_authorize_resource through: :discussion, shallow: true

  def create
    ActiveRecord::Base.transaction do
      @opinion.user = current_user
      @opinion.track(self)
      @opinion.save
    end
    redirect_to @opinion.discussion
  end

  def destroy
    @opinion.destroy
    redirect_to @opinion.discussion
  end

  private

  def opinion_params
    params.require(:opinion).permit(:discussion_id, :body)
  end
end
