class SubscribersController < ApplicationController

  def create
    puts params
    render plain:"yeah #{params}"
  end


end
