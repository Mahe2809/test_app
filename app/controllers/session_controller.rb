class SessionController < ApplicationController
    
    def new

    end

    def create
        # email = params[:session][:email].downcase
        # password = params[:session][:password]
        user = User.find_by(email:params[:session][:email].downcase)
        # byebug
        if (user && user.authenticate(params[:session][:password]))
            session[:user_id] = user.id
            flash[:notice]= "Login in successful"
            redirect_to user_path(user.id)
        else
            flash.now[:alert]= "Login incredentials wrong" 
            # flash works on a one whole refresh of a webpage. So, using flash in 
            # re_direct without the .now will work, where as on rendering the page
            # the page refresh does not take place
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice]= "Logged Out!"
        redirect_to root_path
    end
end