class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user 
    before_action :check_if_same_user, only: [:edit, :update, :destory]

    def new
        @user = User.new
    end

    def index 
        # @users = User.all
        @users = User.paginate(page: params[:page], per_page: 2)
    end

    def show
        @tasks = @user.tasks.paginate(page: params[:page], per_page: 3)
    end

    def create
        # byebug
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome, #{@user.username}"
            redirect_to user_path(@user.id)
        else
            render 'new'
        end
    end

    def edit
    end

    def update

        @user.update(user_params)

        if @user.save
            flash[:notice]= "User Data updated successfully" #Appears only when the user is created.
            redirect_to '/task'
        else
            render 'edit'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] == "Account and all tasks associated removed"
        redirect_to root_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def check_if_same_user
        if current_user.id != @user.id && !current_user.admin?
            flash[:alert] = "Not the same user."
            redirect_to "/task"
        end
    end

end