class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.text :name
      t.datetime :preparation_time
      t.datetime :cooking_time
      t.text :description
      t.boolean :public
      t.bigInt :user_id, index: true

      t.timestamps
    end
  end
end