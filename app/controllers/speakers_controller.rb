class SpeakersController < ApplicationController
  def index
    @presenters = Presenter.order('name ASC')
  end

  def show
    @presenter = Presenter.find(params[:id])
    return redirect_to(speakers_path) unless @presenter.active?
    @episodes = @presenter.episodes.order('published_at DESC')
  end
end

