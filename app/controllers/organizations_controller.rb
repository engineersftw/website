class OrganizationsController < ApplicationController
  def index
    @organizations, @no_logo = Organization.order('title ASC').partition{|organization| organization.image.present? }
  end

  def show
    @organization = Organization.find(params[:id])
    return redirect_to(organizations_path) unless @organization.active?
    @episodes = @organization.episodes.order('published_at DESC')
  end
end
