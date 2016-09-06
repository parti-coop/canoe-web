class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :canoe
  load_and_authorize_resource through: :canoe, shallow: true

  layout 'canoe'

  def create
    @category.user = current_user
    if @category.save
      redirect_to path_with_category(@category)
    else
      redirect_to 'new'
    end
  end

  def edit
    @canoe = @category.canoe
  end

  def update
    if @category.update(category_params)
      redirect_to path_with_category(@category)
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
