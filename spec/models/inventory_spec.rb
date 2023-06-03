require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.new(name: 'User1', email: 'user1@gmail.com', password: "123456") }
  
  subject(:inventory) { Inventory.new(name: "Inv 1")}
  
  let(:food) { Food.create(name: "Food 1", measurement_unit: "kg", price: 3) }
  let(:inventory_food) { InventoryFood.create(quantity: 2) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:inventory_foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
  

  describe '#have recipe food' do
    it 'returns the first inventory food' do
      subject.inventory_foods << inventory_food
      expect(subject.inventory_foods.to_a).to eq([inventory_food])
    end
  end
end