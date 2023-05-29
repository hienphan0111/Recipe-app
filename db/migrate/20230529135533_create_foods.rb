class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.text :name
      t.int :measurement_unit
      t.int :price

      t.timestamps
    end
  end
end