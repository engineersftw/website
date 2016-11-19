class PresentersController < ApplicationController
  def index
    @presenters, @no_avatar = Presenter.order('name ASC').partition{|presenter| presenter.avatar.present? }
  end

  def search
    @search = search_param[:search]
    @presenters, @no_avatar = Presenter.where("lower(name) like :term or lower(twitter) like :term", {term: "%#{@search.downcase}%"}).order('name ASC').partition{|presenter| presenter.avatar.present? }

    render :index
  end

  def alias
    @presenter = Presenter.find(params[:id])
    return redirect_to(presenter_name_slug_path(name: @presenter.name.parameterize, id: @presenter.id))
  end

  def show
    @presenter = Presenter.find(params[:id])
    return redirect_to(presenters_path) unless @presenter.active?
    @episodes = @presenter.episodes.order('published_at DESC')
  end

  def slug
    @presenter = Presenter.where("lower(twitter)=?", params[:id].downcase).first
    return redirect_to(presenters_path) unless @presenter.active?
    @episodes = @presenter.episodes.order('published_at DESC')

    render :show
  end

  private

  def search_param
    params.permit(:search)
  end
end

