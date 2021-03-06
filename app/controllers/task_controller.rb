class TaskController < ApplicationController

    #takes place for all the following "only" methods. it gets executed before any action takes place
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    #the require_user method runs first to check if the user is logged in or not. 
    #only if he is logged in, will he be able to go to any definitions.
    before_action :require_user 
    before_action :check_if_same_user, only: [:edit, :update, :destory]

    #redirects to show.html.erb
    # route: /task/:id --> Get method
    def show
        # byebug
        # @task = Task.find(params[:id]) 
    end

    #redirects to index.html.erb
    # route: /task --> Get method
    def index 
        user = current_user
        @tasks = user.tasks.paginate(page: params[:page], per_page: 3)
        # @tasks = Task.all
    end

    #redirects to new.html.erb
    # route: /task/new --> Get method
    def new
        # @task = Task.new #This can also be done to avoid empty values in the new file.
    end

    #redirects from new.html.erb
    # route: /task --> Post method
    def create
        @task = Task.new(task_params)
        user = current_user
        # @task.user_id = User.first.id #a hardcode way of referencing
        @task.user_id = User.find_by(id:user).id
        if @task.save
            flash[:notice]= "Article created successfully" #Appears only when the task is created.
            redirect_to task_path(@task)    
        else
            render 'new'
        end
    end

    #redirects to edit.html.erb
    # route: /task/:id/edit --> Get method
    def edit 
        # @task = Task.find(params[:id]) #This can also be done to avoid empty values in the new file.
    end

    #redirects from edit.html.erb
    # route: /task/:id/edit --> Patch/post method
    def update
        # @task = Task.find(params[:id])

        @task.update(task_params)

        if @task.save
            flash[:notice]= "Article updated successfully" #Appears only when the task is created.
            redirect_to task_path(@task)    
        else
            render 'edit'
        end
    end

    #redirects to none.  it is a destroy method
    # route: /task/:id --> destroy method
    def destroy
        # @task = Task.find(params[:id])
        @task.destroy
        redirect_to '/task'
    end
    
    #methods below this private are accessible only in this file.
    private

    #sets @task with the task selected and of that id in params
    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:task, :comments)
    end

    def check_if_same_user
        if current_user.id != @task.user_id && !current_user.admin?
            flash[:alert] = "Cannot edit that task. You have no access to edit that task"
            redirect_to "/task"
        end
    end

end