class SailingDiariesController < ApplicationController
  before_action :load_canoe
  load_and_authorize_resource

  layout 'canoe'

  def index
    @sailing_diaries = @canoe.sailing_diaries.recent
    @sailing_diary = SailingDiary.new
  end

  def new
    @sailing_diary.sailed_on = Date.current
  end

  def create
    @sailing_diary.canoe = @canoe
    @sailing_diary.user = current_user
    @sailing_diary.save

    redirect_to canoe_sailing_diaries_path(@canoe)
  end

  def edit
  end

  def update
    if @sailing_diary.update_attributes(sailing_diary_params)
      redirect_to canoe_sailing_diaries_path(@canoe)
    else
      render 'edit'
    end
  end

  def destroy
    @sailing_diary.destroy
    redirect_to canoe_sailing_diaries_path(@canoe)
  end

  private

  def load_canoe
    @canoe = Canoe.find(params[:canoe_id])
  end

  def sailing_diary_params
    params.require(:sailing_diary).permit(:body, :sailed_on)
  end
end
