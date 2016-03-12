class SubscribersController < ApplicationController

  def create
    email = params[:email]
    first_name = params[:first_name]

    begin
      MailchimpService.new.subscribe(email, first_name)
      redirect_to root_path, notice: "Welcome to the mailing list!"
    rescue Gibbon::MailChimpError => e
      redirect_to root_path, alert: e.detail
    end
  end

end