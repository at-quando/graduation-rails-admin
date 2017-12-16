module SessionsHelper
	def log_in user
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete :user_id
  end

  def current_user
    return unless session[:user_id]
    if(Admin.find(session[:user_id])!=nil)
   	  @current_user ||= Admin.find(session[:user_id])
   	else
   		log_out
   	  redirect_to login_path
   	end
  end
 def logged_in?
    !current_user.nil?
  end

   # Confirms a logged-in user.
  # def user_signed_in?
  #   unless logged_in?
  #     flash[:danger] = "Please log in."
  #     redirect_to login_path
  #   end
  # end
end
