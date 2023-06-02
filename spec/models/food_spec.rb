require 'rails_helper'

RSpec.describe Food, type: :model do
  subject { Food.new(name: 'Food1', measurement_unit: 'kg', price: 12) }

  let(:recipe_food) { RecipeFood.create(quantity: 2) }
  let(:inventory_food) { InventoryFood.create(quantity: 3)}

  # before { subject.save, post1.save, post2.save, post3.save }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it 'Name is expected present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "returns right number of recipe foods and inventory foods" do
    subject.recipe_foods << recipe_food
    subject.inventory_foods << inventory_food
    expect(subject.recipe_foods.to_a).to eq([recipe_food])
    expect(subject.inventory_foods.to_a).to eq([inventory_food])
  end
end
