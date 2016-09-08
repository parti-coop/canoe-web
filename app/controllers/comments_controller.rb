class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :opinion
  load_and_authorize_resource :opinion
  load_and_authorize_resource through: :opinion, shallow: true

  def create
    @comment.user = current_user

    ok = false
    ActiveRecord::Base.transaction do
      ok = @comment.save and @comment.commentable.try(:track)
    end
    push_to_slack(@comment) if ok

    redirect_back fallback_location: @comment.commentable.mode_for_show
  end

  def destroy
    if @comment.destroy
      push_to_slack(@comment)
    end
    redirect_back fallback_location: @comment.commentable.mode_for_show
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
