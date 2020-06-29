class TaskController < ApplicationController
    def show
        # byebug
        @task = Task.find(params[:id])
    end
    def index 
        @tasks = Task.all
    end
    def new

    end
    def create
        @task = Task.new(params.require(:task).permit(:task, :comments))
        # render plain: @task.inspect
        @task.save
        redirect_to task_path(@task)
        # 
        
    end
    
end