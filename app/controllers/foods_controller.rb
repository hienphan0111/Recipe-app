class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def show; end

  def create
    @food = current_user.foods.new(food_params)
    puts foods.inspect
    if @food.save
      flash[:success] = 'Food created!'
      redirect_to foods_path @food
    else
      flash[:alert] = 'Food not created!'
      render :index
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:success] = 'Food deleted!'
      redirect_to foods_path
    else
      flash[:alert] = 'Food not deleted!'
      render :index
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :meaurement_unit, :quantity, :price, :expiration_date, :user_id)
  end
end
