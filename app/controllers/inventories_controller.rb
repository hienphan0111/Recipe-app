class InventoriesController < ApplicationController
  before_action :find_post, only: [:destroy]

  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def destroy
    @inventory.destroy
    redirect_to inventories_path
  end
end
