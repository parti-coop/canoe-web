class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :opinion
  load_and_authorize_resource through: :opinion, shallow: true

  def create
    @comment.user = current_user
    if @comment.save
      push_to_slack(@comment)
    end
    redirect_back fallback_location: @comment.discussion
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
