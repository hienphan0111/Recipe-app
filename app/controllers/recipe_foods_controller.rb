class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!, :cur_recipe

  def new; end

  def create
    if current_user
      if @recipe.recipe_foods.any? { |i| i.food.id == recipe_food_params[:food_id].to_i }
        flash[:alert] = 'Food was exist in this inventory'
      else
        recipe_food = RecipeFood.new(recipe_food_params)
        recipe_food.food = Food.find(recipe_food_params[:food_id])
        recipe_food.recipe = @recipe
        if recipe_food.save
          flash[:notice] = 'Food was added successfully'
        else
          flash.now[:alert] = 'Error! can not add the food'
        end
      end
      redirect_to new_recipe_recipe_food_path(@recipe)
    else
      flash.now[:alert] = 'You need to login before add food'
      redirect_to new_user_session_path
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe.recipe_foods.include?(@recipe_food)
      @recipe_food&.destroy
    else
      flash.now[:alert] = 'Food does not exist'
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_food_params
    params.required(:recipe_food).permit(:food_id, :quantity)
  end

  def cur_recipe
    @recipe = Recipe.includes(:recipe_foods).find(params[:recipe_id])
  end
end
