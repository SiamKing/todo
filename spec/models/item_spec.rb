require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    List.destroy_all
    Item.destroy_all
    create_valid_user('foo@bar.com', 'foobar33')
    @list = List.create!(name: "Shopping List", user_id: @valid_user.id)
    @item = @list.items.create!(description: "Creamer")
  end

  it "can be created with valid attributes" do
    expect(@item).to be_valid
  end

  it "is invalid without a description" do
    @invalid_item = Item.new

    expect(@invalid_item).to be_invalid
  end

  it "is invalid if it is already on list" do
    @non_unique_item = @list.items.new(description: "Creamer")

    expect(@non_unique_item).to be_invalid
  end

  it "can create list association" do
    @list1 = List.create!(name: "Work List", user_id: @valid_user.id)
    @item1 = Item.new(description: "Build out list functionality")
    @item1.list = @list1
    @item1.save!
    
    expect(@item1.list).to eq(@list1)
  end

end
