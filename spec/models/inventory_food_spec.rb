require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  subject(:inventory_food) { InventoryFood.new(quantity: 2)}

  let(:food) { Food.create(name: "Food 1", measurement_unit: "kg", price: 3) }
  let(:inventory) { Inventory.create(name: "First") }

  describe 'associations' do
    it { should belong_to(:inventory) }
    it { should belong_to(:food) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(0) }
  end

end