class PlanController < ApplicationController
  before_action :load_categories, only: %i(new create)

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build plan_params
    if @plan.save
      flash[:success] = t ".create_successfully"
      redirect_to :new_plan
    else
      # flash.now[:danger] = t ".error"
      render :new
    end
  end

  private

  def plan_params
    params.require(:plan).permit :month,
                                 :spending_category,
                                 :type_money,
                                 :status,
                                 :moneys,
                                 :category_id
  end

  def load_categories
    @categories = current_user.categories.activate
  end
end
