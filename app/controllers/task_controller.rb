class TaskController < ApplicationController

    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def show
        # byebug
        # @task = Task.find(params[:id])
    end
    def index 
        @tasks = Task.all
    end
    def new
        # @task = Task.new #This can also be done to avoid empty values in the new file.
    end
    def create
        @task = Task.new(task_params)
        @task.user_id = User.first.id #a hardcode way of referencing
        if @task.save
            flash[:notice]= "Article created successfully" #Appears only when the task is created.
            redirect_to task_path(@task)    
        else
            render 'new'
        end
    end

    def edit 
        # @task = Task.find(params[:id]) #This can also be done to avoid empty values in the new file.
    end

    def update
        # @task = Task.find(params[:id])

        @task.update(task_params)

        if @task.save
            flash[:notice]= "Article updated successfully" #Appears only when the task is created.
            redirect_to task_path(@task)    
        else
            render 'new'
        end
    end

    def destroy
        # @task = Task.find(params[:id])
        @task.destroy
        redirect_to '/task'
    end
    
    private

    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:task, :comments)
    end

end