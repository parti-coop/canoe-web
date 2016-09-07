class OpinionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :discussion
  load_and_authorize_resource through: :discussion, shallow: true

  def create
    @opinion.user = current_user
    @opinion.track(self)

    if @opinion.save
      push_to_slack(@opinion)
    end
    redirect_to @opinion.discussion
  end

  def destroy
    if @opinion.destroy
      push_to_slack(@opinion)
    end
    redirect_to @opinion.discussion
  end

  private

  def opinion_params
    params.require(:opinion).permit(:discussion_id, :body)
  end
end
