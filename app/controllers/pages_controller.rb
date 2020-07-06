class PagesController < ApplicationController
    def home
        redirect_to '/task' if logged_in?
    end

    def about
    end
end
