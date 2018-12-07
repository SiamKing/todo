require "rails_helper"

RSpec.describe List, type: :model do

    before(:all) do
        List.destroy_all
        Item.destroy_all
        @list1 = List.create!(name: "Shopping List")
        @item1 = Item.create!(description: "Soy Milk")
    end

    it "is valid with valid attributes" do
        expect(@list1).to be_valid
    end

    it "should be able to create association with item using an item object" do
        @list1.items << @item1
        expect(@list1.items.last).to eq @item1
    end

end