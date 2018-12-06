require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    List.destroy_all
    Item.destroy_all
    @list = List.create!(name: "Shopping List")
    @item = @list.items.create!(description: "Creamer", list_id: 1)
  end

  it "can be created with valid attributes" do
    expect(@item).to be_valid
  end

  it "is invalid without a description" do
    @invalid_item = Item.new
    expect(@invalid_item).to be_invalid
  end

end