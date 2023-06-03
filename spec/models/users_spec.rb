require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'User1', email: 'user@gmail.com', password: "123456") }

  let(:recipe) { Recipe.create(name: "First",preparation_time: 2, cooking_time: 1, description: "This is the first recipe", is_public: true) }
  let(:inventory) { Inventory.create()}

  # before { subject.save, post1.save, post2.save, post3.save }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it 'Name is expected present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "returns right number of recipes" do
    subject.recipes << recipe
    subject.inventories << inventory
    expect(subject.recipes.length).to eq(1)
  end
end
