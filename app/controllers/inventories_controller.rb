class InventoriesController < ApplicationController
  before_action only: [:destroy]

  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new; end

  def create
    if current_user
      inv = Inventory.new(inventory_params)
      inv.user = current_user
      if inv.save
        flash[:notice] = 'Inventory was created successfully'
        redirect_to inventories_path
      else
        flash.now[:alert] = 'Error! can not create inventory'
      end
    else
      flash.now[:alert] = 'You need to login to crate inventory'
      redirect_to new_user_session_path
    end
  end

  def destroy
    @inventory.destroy
    redirect_to inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
