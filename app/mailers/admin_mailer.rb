class AdminMailer < ApplicationMailer
  def send_when_login

  end
	def registration_email(user,password)
		@user = user
		@password = password
		mail(:to => "#{user.email}", :subject => " Registration for FANATIC App")
	end

	def registration_email_assistant(user,password)
		@user = user
		@password = password
		mail(:to => "#{user}", :subject => " Registration for FANATIC App")
	end

	def password_reset(user)
		@user = user
		mail(:to => "#{user.email}", :subject => " Reset Password for FANATIC App")
	end
end
