class SessionsController < ApplicationController

    def new
        redirect_to user_lists_path(current_user) if current_user
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_lists_path(@user)
        else
            redirect_to new_user_path
        end
    end

    def facebook_create
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
        end
        if @user.password.nil?
            @user.password = SecureRandom.urlsafe_base64(n=6)
            @user.save
        end

        session[:user_id] = @user.id
        redirect_to user_lists_path(@user)
    end

    def destroy
        reset_session
        redirect_to login_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end
