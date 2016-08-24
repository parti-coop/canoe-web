class OpinionsController < ApplicationController
  load_and_authorize_resource

  def create
    @opinion.user = current_user
    @opinion.save
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