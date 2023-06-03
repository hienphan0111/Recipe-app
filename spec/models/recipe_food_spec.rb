require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  subject(:recipe_food) { RecipeFood.new(quantity: 2)}

  let(:food) { Food.create(name: "Food 1", measurement_unit: "kg", price: 3) }
  let(:recipe) { Recipe.create(name: "First",preparation_time: 2, cooking_time: 1, description: "This is the first recipe", is_public: true) }

  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end

end
