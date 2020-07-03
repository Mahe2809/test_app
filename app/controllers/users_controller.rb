class UsersController < ApplicationController

    before_action :set_user, only: [:edit]

    def new
        @user = User.new
    end

    def index 
        # @users = User.all
        @users = User.paginate(page: params[:page], per_page: 2)
    end

    def show
        @user = User.find(params[:id])
        @tasks = @user.tasks.paginate(page: params[:page], per_page: 3)
    end

    def create
        # byebug
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome, #{@user.username}"
            redirect_to users_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update

        @user = User.find(params[:id])

        @user.update(user_params)

        if @user.save
            flash[:notice]= "User Data updated successfully" #Appears only when the user is created.
            redirect_to users_path
        else
            render 'edit'
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end