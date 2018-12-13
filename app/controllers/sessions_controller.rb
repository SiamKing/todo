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

    def destroy
        reset_session
        redirect_to login_path
    end
end
