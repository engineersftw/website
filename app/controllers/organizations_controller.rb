class OrganizationsController < ApplicationController
  def index
    @organizations, @no_logo = Organization.order('title ASC').partition{|organization| organization.image.present? }
  end

  def show
    @organization = Organization.find(params[:id])
    return redirect_to(organizations_path) unless @organization.active?
    @episodes = @organization.episodes.active.order('published_at DESC')
  end

  def alias
    @organization = Organization.find(params[:id])
    redirect_to organization_name_path(name: @organization.title.parameterize, id: @organization.id)
  end
end
