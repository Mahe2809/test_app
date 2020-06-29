class TaskController < ApplicationController
    def show
        # byebug
        @task = Task.find(params[:id])
    end
    def index 
        @tasks = Task.all
    end
end