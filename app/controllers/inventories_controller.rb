class InventoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inventories = Inventory.all.where(user: current_user)
  end

  def show
    @inventory = Inventory.find(params[:id])
    return unless @inventory.user != current_user || !@inventory

    flash[:notice] = 'You are not owner of this inventory or inventory not found'
    redirect_to inventories_path
  end

  def new; end

  def create
    inv = Inventory.new(inventory_params)
    inv.user = current_user
    if inv.save
      flash[:notice] = 'Inventory was created successfully'
      redirect_to inventories_path
    else
      flash.now[:alert] = 'Error! can not create inventory'
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    if @inventory.user == current_user
      @inventory.destroy
    else
      flash[:notice] = 'You are not allowed to delete this inventory'
    end
    redirect_to inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
