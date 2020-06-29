class TaskController < ApplicationController
    def show
        # byebug
        @task = Task.find(params[:id])
    end
end