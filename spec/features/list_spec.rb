require 'rails_helper'
require 'spec_helper'

RSpec.describe List, type: :feature do

    before do
        List.destroy_all
        Item.destroy_all
        create_valid_user('foo@bar.com', 'foobar33')
        @list1 = @valid_user.lists.create!(name: "Shopping List")
        @list2 = @valid_user.lists.create!(name: "Cleaning List")
        @list3 = @valid_user.lists.create!(name: "Cooking List")
        @item1 = @list1.items.create!(description: "Soy Milk")
        @item2 = @list1.items.create!(description: "Pizza")
    end

    describe 'Index page' do
        it 'has a view page' do
            visit_login #login_helper

            expect(current_path).to eq('/users/1/lists')
        end

        it "shows all of the users lists" do
            visit_login

            expect(page).to have_content(/Shopping List|Cleaning List|Cooking List/)
        end

        it "can create a new list with valid name" do
            visit_login
            fill_in "list_name", with: "Bar List"
            find("#create-list", visible: false).click

            expect(page).to have_content(/Bar List/)
        end

        it "will not create a new list with a blank name" do
            visit_login
            find("#create-list", visible: false).click

            expect(page).to have_css("div.field_with_errors")
        end
    end

    describe 'Show page' do

        it 'has a view page' do
            visit_user_list
            expect(page.status_code).to eq(200)
        end

        it 'shows the list name' do
            visit_user_list
            expect(page).to have_content(/Shopping List/)
        end

        it "shows the associated items in the list" do
            visit_user_list
            expect(page).to have_content(/Soy Milk|Pizza/)
        end

        it "can create a new list item" do
            visit_user_list
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
            visit_user_list
            find("#item_1 input.destroy").click

            expect(page).to have_no_content(/Soy Milk/)
            expect(page).to have_content(/Pizza/)
        end
    end

end