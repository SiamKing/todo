module LoginHelper
    def user_signup(email, password)
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        find('input[type="submit"]', visible: false).click
    end

    def user_login(email, password)
        fill_in 'email', with: email
        fill_in 'password', with: password
        find('input[type="submit"]', visible: false).click
    end

    def create_valid_user(email, password)
        @valid_user = User.create!(email: email, password: password)
    end

    def visit_login
        visit login_path
        user_login('foo@bar.com', 'foobar33')
    end

    def visit_user_list
        visit_login
        visit user_list_path(@valid_user, @list1)
    end

end