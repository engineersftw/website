class PresentersController < ApplicationController
  def index
    @presenters, @no_avatar = Presenter.order('name ASC').partition{|presenter| presenter.avatar.present? }
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
end

