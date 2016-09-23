class OpinionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :discussion
  load_and_authorize_resource through: :discussion, shallow: true

  layout 'canoe'

  def create
    @opinion.user = current_user
    @opinion.track

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

  def edit
    @canoe = @opinion.canoe
    @discussion = @opinion.discussion
  end

  def update
    if @opinion.update_attributes(update_params)
      redirect_to @opinion.discussion
    else
      render 'edit'
    end
  end

  private

  def create_params
    params.require(:opinion).permit(:discussion_id, :body)
  end

  def update_params
    params.require(:opinion).permit(:body)
  end
end
