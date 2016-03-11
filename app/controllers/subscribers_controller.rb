class SubscribersController < ApplicationController

  def create
  	email = params[:email]
  	first_name = params[:first_name]

    result = MailchimpService.new.subscribe(email, first_name)
	if result
		# flash message! You are in!
		redirect_to root_path, notice: "Welcome to the mailing list!"
	else
		# oh no!
		redirect_to root_path, alert: "Sorry, something went wrong."
	end
  end


end