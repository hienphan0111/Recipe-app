class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.int :quantity
      t.bigInt :recipe_id, index: true
      t.bigInt :food_id, index: true
      t.timestamps
    end
  end
end