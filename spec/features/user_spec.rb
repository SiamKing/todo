require 'rails_helper'

RSpec.describe User, type: :feature do

    describe 'signup feature' do
        it 'should signup with valid email and password' do
            visit new_user_path
            user_signup('foo@bar.com', 'foobar33')

            expect(page).to have_content('foo@bar.com')
        end

        it 'should not signup if email is not unique' do
            create_valid_user('pootie@tang.com', 'pootie33')
            visit new_user_path
            user_signup('pootie@tang.com', 'pootie33')

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
            user_signup('kit@kat.com', 'kit')

            expect(page).to have_selector('input', id: "user_email")
            expect(page).to have_selector('input', id: "user_password")
        end
    end

    describe 'login view' do
        it 'should login user with valid email and password' do
            create_valid_user('foo@bar.com', 'foobar33')
            visit login_path
            user_login('foo@bar.com', 'foobar33')

            expect(page).to have_content('foo@bar.com')
        end

        it 'should not login with when email and password are not given and redirect to signup path' do
            visit login_path
            find('input[type="submit"]', visible: false).click

            expect(page).to have_selector('input', id: "user_email")
            expect(page).to have_selector('input', id: "user_password")
        end
    end

    
end