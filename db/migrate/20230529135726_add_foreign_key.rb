class AddForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :users, foreign_key: true
    add_reference :inventories, :users, foreign_key: true
    add_reference :inventory_foods, :inventories, foreign_key: true
    add_reference :inventory_foods, :foods, foreign_key: true
    add_reference :recipe_foods, :recipes, foreign_key: true
    add_reference :recipe_foods, :foods, foreign_key: true
  end
end
