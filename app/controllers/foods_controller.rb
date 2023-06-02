class FoodsController < ApplicationController
  before_action :authenticate_user!, :all_foods

  def index
    @foods = Food.all
  end

  def create
    food = Food.new(food_params)
    if food.save
      flash[:success] = 'Food created!'
      redirect_to foods_path
    else
      flash[:alert] = 'Food not created!'
      render :index
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:notice] = 'Food deleted!'
    else
      flash[:alert] = 'Food not deleted!'
    end
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end

  def all_foods
    @foods = Food.all
  end
end
