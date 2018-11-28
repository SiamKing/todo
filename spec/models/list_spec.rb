require "rails_helper"

RSpec.describe List, type: :model do

    before(:all) do
        @list1 = create(:list)
    end

    it "is valid with valid attributes" do
        expect(@list1).to be_valid
    end

end