class TaskController < ApplicationController
    def show
        # byebug
        @task = Task.find(params[:id])
    end
    def index 
        @tasks = Task.all
    end
    def new
        # @task = Task.new #This can also be done to avoid empty values in the new file.
    end
    def create
        @task = Task.new(params.require(:task).permit(:task, :comments))

        if @task.save
            flash[:notice]= "Article created successfully" #Appears only when the task is created.
            redirect_to task_path(@task)    
        else
            render 'new'
        end
    end

    def edit 
        @task = Task.find(params[:id]) #This can also be done to avoid empty values in the new file.
    end

    def update
        @task = Task.find(params[:id])

        @task.update(params.require(:task).permit(:task, :comments))

        if @task.save
            flash[:notice]= "Article updated successfully" #Appears only when the task is created.
            redirect_to task_path(@task)    
        else
            render 'new'
        end
    end
    
end