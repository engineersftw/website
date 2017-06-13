 class ApiController < ApplicationController

  def organizations
    @organizations = Organization.order('title ASC')
  end

  def presenters
    @presenters = Presenter.order('name ASC')
  end

end
