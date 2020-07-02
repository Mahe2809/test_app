class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        # byebug
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome, #{@user.username}"
            redirect_to "/task"
        else
            render 'new'
        end
    end


    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end