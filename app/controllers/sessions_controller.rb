class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  skip_load_and_authorize_resource

  def new
    if logged_in?
      redirect_to admins_path
    end
  end

  def create
   user = Admin.find_by email: params[:session][:user_name].downcase
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
          flash[:success] = "Login success"
          log_in user
          redirect_to root_path
    else
      # Create an error message.
       # Not quite right!
      flash[:alert] = 'Invalid email/password combination'
      render 'new'
      
  	end
 	end
  
 	def destroy

    log_out
    flash[:success] = "You are logged out"
    redirect_to login_path
  end
end
