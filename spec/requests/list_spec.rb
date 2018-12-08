require 'rails_helper'

describe "lists", type: :feature do

    before do
        List.destroy_all
        Item.destroy_all
        @list1 = List.create!(name: "Shopping List")
        @list2 = List.create!(name: "Cleaning List")
        @list3 = List.create!(name: "Cooking List")
        @item1 = Item.create!(description: "Soy Milk")
        @item2 = Item.create!(description: "Pizza")
        @list1.items << @item1
        @list1.items << @item2
    end

    describe 'Index page' do
        it 'has a view page' do
            visit '/lists'

            expect(page.status_code).to eq(200)
        end

        it "on the index page" do
            lists = List.all

            visit "/lists"

            expect(page).to have_content(/Shopping List|Cleaning List|Cooking List/)
        end

        it "can create a new list with valid name" do
            visit lists_path
            fill_in "list_name", with: "Bar List"
            find("#create-list", visible: false).click

            expect(page).to have_content(/Bar List/)
        end

        it "will not create a new list with a blank name" do
            visit lists_path
            find("#create-list", visible: false).click

            expect(page).to have_css("div.field_with_errors")
        end
    end

    describe 'Show page' do

        it 'has a view page' do
            visit list_path(@list1)
            expect(page.status_code).to eq(200)
        end

        it 'shows the list name' do
            visit list_path(@list1)
            expect(page).to have_content(/Shopping List/)
        end

        it "shows the associated items in the list" do
            visit list_path(@list1)
            expect(page).to have_content(/Soy Milk|Pizza/)
        end

        it "can create a new list item" do
            visit list_path(@list1)
            fill_in "item_description",	with: "Vodka"
            find('#create-item', visible: false).click

            expect(page).to have_content(/Vodka/)
        end

        # it "can check complete box to update item's status" do
        #     visit list_path(@list1)
        #     find("#edit_item_1 input[type='checkbox']").click
        #     save_and_open_page
        #     expect(page).to have_css("li.completed")
        # end

        it "can delete an item from the list" do
            visit list_path(@list1)
            find("#item_1 input.destroy").click

            expect(page).to have_no_content(/Soy Milk/)
            expect(page).to have_content(/Pizza/)
        end
    end

end