require 'rails_helper'

describe 'Index page' do
    it 'has a view page' do
        visit '/lists'

        expect(page.status_code).to eq(200)
    end

    it "on the index page" do
        lists = Array.new
        lists.push(List.create!(name: "Shopping List"), List.create!(name: "Cleaning List"), List.create!(name: "Cooking List"))

        visit "/lists"

        expect(page).to have_content(/Shopping List|Cleaning List|Cooking List/)
    end
end

describe 'Show page' do
    before do
        @list = List.create!(name: "Shopping List")
    end

    it 'has a view page' do
        visit "lists/#{@list.id}"
        expect(page.status_code).to eq(200)
    end

    it 'shows the list name' do
        visit "lists/#{@list.id}"
        expect(page).to have_content(/Shopping List/)
    end
end