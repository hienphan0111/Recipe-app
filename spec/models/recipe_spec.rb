require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(name: 'User1', email: 'user1@gmail.com', password: "123456") }
  
  subject do
    described_class.new(
      user: user,
      name: "First",
      preparation_time: 2,
      cooking_time: 1,
      description: "This is the first recipe",
      is_public: true
    )
  end
  
  let(:food) { Food.create(name: "Food 1", measurement_unit: "kg", price: 3) }
  let(:recipe_food) { RecipeFood.create(quantity: 2) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:preparation_time).is_greater_than(0) }
    it { should validate_numericality_of(:cooking_time).is_greater_than(0) }
  end
  

  describe '#have recipe food' do
    it 'returns the first recipe food' do
      subject.recipe_foods << recipe_food
      expect(subject.recipe_foods.to_a).to eq([recipe_food])
    end
  end
end