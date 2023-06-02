class InventoryFoodsController < ApplicationController
  before_action :inventory

  def new
    @inv = Inventory.find(params[:inventory_id])
  end

  def create
    if current_user
      if @inv.inventory_foods.any? { |i| i.food.id == inv_food_params[:food_id].to_i }
        flash[:alert] = 'Food was exist in this inventory'
      else
        inv_food = InventoryFood.new(inv_food_params)
        inv_food.food = Food.find(inv_food_params[:food_id])
        inv_food.inventory = @inv
        if inv_food.save
          flash[:notice] = 'Food was added successfully'
        else
          flash.now[:alert] = 'Error! can not add the food'
        end
      end
      redirect_to new_inventory_inventory_food_path(@inv)
    else
      flash.now[:alert] = 'You need to login before add food'
      redirect_to new_user_session_path
    end
  end

  def destroy
    @inv_food = InventoryFood.find(params[:id])
    if @inv.inventory_foods.include?(@inv_food)
      @inv_food&.destroy
    else
      flash.now[:alert] = 'Food does not exist'
    end
    redirect_to inventory_path(@inv)
  end

  private

  def inv_food_params
    params.require(:inventory_food).permit(:quantity, :food_id)
  end

  def inventory
    @inv = Inventory.find(params[:inventory_id])
  end
end
