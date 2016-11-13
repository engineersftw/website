class OrganizationsController < ApplicationController
  def index
    @organizations, @no_logo = Organization.order('title ASC').partition{|organization| organization.image.present? }
  end

  def show
    @organization = is_number?(params[:id]) ? Organization.find(params[:id]) : Organization.find_by_slug(params[:id])
    return redirect_to(organizations_path) if @organization.nil? || !@organization.active?
    @episodes = @organization.episodes.active.order('published_at DESC')
  end

  def alias
    @organization = Organization.find(params[:id])
    if @organization.slug.present?
      redirect_to organization_slug_path(id: @organization.slug)
    else
      redirect_to organization_name_path(name: @organization.title.parameterize, id: @organization.id)
    end
  end
end
