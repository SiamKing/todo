require 'rails_helper'

RSpec.describe User, type: :views do
    before do
        @user = User.create!(email: 'foo@bar.com', password: 'foobar33')
    end

    describe 'login view' do
        it 'should login user with valid email and password' do
            visit login_path
            fill_in 'email', with: 'foo@bar.com'
            fill_in 'password', with: 'foobar33'
            find('input[type="submit"]', visible: false).click

            expect(page).to have_content('foo@bar.com')
        end

        it 'should not login with when email and password are not given and redirect to signup path' do
            visit login_path
            find('input[type="submit"]', visible: false).click

            expect(page).to have_selector('input', id: "user_email")
            expect(page).to have_selector('input', id: "user_password")
        end
    end

    describe 'signup view' do
        it 'should signup with valid email and password' do
            visit new_user_path
            fill_in 'user_email', with: 'pootie@tang.com'
            fill_in 'user_password', with: 'pootie33'
            find('input[type="submit"]', visible: false).click

            expect(page).to have_content('pootie@tang.com')
        end

        it 'should not signup if email is not unique' do
            visit new_user_path
            fill_in 'user_email', with: 'foo@bar.com'
            fill_in 'user_password', with: 'foobar33'
            find('input[type="submit"]', visible: false).click

            expect(page).to have_selector('input', id: "user_email")
            expect(page).to have_selector('input', id: "user_password")
        end
        
        it 'should not signup if email is blank' do
            visit new_user_path
            find('input[type="submit"]', visible: false).click

            expect(page).to have_selector('input', id: "user_email")
            expect(page).to have_selector('input', id: "user_password")
        end

        it 'should not signup if password length is too short' do
            visit new_user_path
            fill_in 'user_email', with: 'kit@kat.com'
            fill_in 'user_password', with: 'kitkat'
            find('input[type="submit"]', visible: false).click

            expect(page).to have_selector('input', id: "user_email")
            expect(page).to have_selector('input', id: "user_password")
        end
    end
end