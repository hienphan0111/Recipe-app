class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipes index show]

  def index
    if user_signed_in?
      @recipes = Recipe.includes(:recipe_foods).where(user: current_user)
    else
      public_recipes
    end
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    if user_signed_in? || @recipe.is_public
      @inventories = current_user.inventories if @recipe.user == current_user
      render 'show'
    else
      flash[:notice] = 'The recipe is private, you need login to see it'
      redirect_to recipes_path
    end
  end

  def new; end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      flash[:notice] = 'recipe was created successfully.'
      redirect_to recipes_path
    else
      flash.now[:alert] = 'Error! recipe was not created.'
      render :new
    end
  end

  def public_recipes
    @recipes = Recipe.includes(:recipe_foods).where(is_public: true).order(created_at: :desc)
  end

  def remove_food
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe.recipe_foods.delete(params[:recipe_food])
    if @recipe.save
      redirect_to recipe_path
    else
      flash.now[:alert] = 'Error! can not remove food from recipe'
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.is_public = public_params[:is_public]
    @recipe.save
  end

  def shopping_list
    @recipe = Recipe.includes(:recipe_foods).find(params[:recipe_id])
    @foods = @recipe.recipe_foods
    @inv_selected = Inventory.find(params[:inventory_id])
    inv_foods = @inv_selected.inventory_foods
    @miss_foods = []
    @foods.each do |food|
      food_in_inv = inv_foods.find { |i| i.food.id == food.food.id }
      if food_in_inv.present? && food_in_inv.quantity < food.quantity
        food_in_inv.quantity = food.quantity - food_in_inv.quantity
        @miss_foods << food_in_inv
      else
        @miss_foods << food
      end
    end
    render 'shopping_list'
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if user_signed_in? && @recipe.user == current_user
      @recipe.destroy
    else
      flash[:alert] = 'You are not allowed to delete this recipe'
    end
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.required(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :is_public)
  end

  def public_params
    params.required(:recipe).permit(:is_public)
  end

  def find_recipe
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
  end
end
