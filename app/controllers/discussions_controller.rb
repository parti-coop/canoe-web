class DiscussionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource :canoe
  load_and_authorize_resource through: :canoe, shallow: true

  layout 'canoe'

  def index
    @discussions = @canoe.discussions.order("id DESC")
    @category = @canoe.categories.find params[:category_id] if params[:category_id].present?
    @discussions = @discussions.in_category(@category)
  end

  def show
    @canoe = @discussion.canoe
    @discussion.mark_as_read! for: current_user if user_signed_in?
  end

  def new
    @discussion.category = @canoe.categories.find_by id: params[:category_id]
  end

  def create
    @discussion.canoe = @canoe
    @discussion.user = current_user
    if @discussion.save
      push_to_slack(@discussion)
    end

    redirect_to @discussion || @canoe
  end

  def edit
    @canoe = @discussion.canoe
  end

  def update
    if @discussion.update_attributes(discussion_params)
      push_to_slack(@discussion)
      redirect_to @discussion
    else
      render 'edit'
    end
  end

  def consensus
    @discussion.assign_attributes(params.require(:discussion).permit(:consensus))
    @consensus_revision = @discussion.consensus_revisions.build(user: current_user, body: @discussion.consensus)
    @consensus_revision.track(self)
    if @discussion.consensus_changed? and @discussion.save
      push_to_slack(@discussion)
      redirect_to @discussion
    else
      @canoe = @discussion.canoe
      render 'edit_consensus'
    end
  end

  def edit_consensus
    @canoe = @discussion.canoe
  end

  def destroy
    if @discussion.destroy
      push_to_slack(@discussion)
    end
    redirect_to @canoe
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body, :category_id)
  end
end
