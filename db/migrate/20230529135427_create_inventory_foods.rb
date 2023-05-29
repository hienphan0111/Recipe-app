
class CreateInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_foods do |t|
      t.int :quantity
      t.bigInt :inventory_id
      t.bigInt :food_id
      t.timestamps
    end
  end
end