Rails.application.routes.draw do

  devise_config = ActiveAdmin::Devise.config
  devise_config[:controllers][:omniauth_callbacks] = 'users/omniauth_callbacks'
  devise_for :users, devise_config

  ActiveAdmin.routes(self)
  resources :episodes, only: [:index, :show] do
    collection do
      get '/search', to: 'episodes#search'
    end
  end
  get 'playlist/:id', to: 'episodes#playlist', as: 'playlist'
  get 'conference/:id', to: 'episodes#playlist', as: 'conference'
  get 'feed', to: 'episodes#index', format: 'atom'

  resources :organizations, only: [:index]
  resources :subscribers, only: [:create]

  root 'welcome#index'
  get 'about' => 'welcome#about'
  get 'events' => 'welcome#events'
  get 'conferences' => 'welcome#conferences'
  get 'bookings' => 'welcome#bookings'
  get 'live' => 'welcome#live'
  get 'fb_live' => 'welcome#fb_live'
  get 'support_us' => 'welcome#support_us'

  get 'videos/:tag', to: 'episodes#index', as: :tag
  get 'v/:id', to: 'episodes#alias', as: 'video'
  get 'video/*title--:id', to: 'episodes#show', as: 'video_slug'
  get ':id', to: 'episodes#show', as: 'video_shortcut', constraints: { id: /[0-9]+/ }

  get 'presenters', to: 'presenters#index', as: 'presenters'
  get 'presenters/search', to: 'presenters#search', as: 'presenters_search'
  get 'presenters/:id', to: 'presenters#alias', as: 'presenter'
  get 's/:id', to: redirect('/presenter/%{id}'), as: 'speaker'
  get 'presenter/*name--:id', to: 'presenters#show', as: 'presenter_name_slug'
  get 'presenter/:id', to: 'presenters#slug', as: 'presenter_slug'

  get '/video/new-directions-in-cryptography-papers-we-love', to: redirect('/video/new-directions-in-cryptography-papers-we-love--601')

  get 'organization/*name--:id', to: 'organizations#show', as: 'organization_name'
  get 'organizations/:id', to: 'organizations#alias', as: 'organization_show', constraints: { id: /[0-9]+/ }
  get 'organization/:id', to: 'organizations#alias', as: 'organization_alias', constraints: { id: /[0-9]+/ }
  get 'org/:id', to: 'organizations#alias', constraints: { id: /[0-9]+/ }
  get 'o/:id', to: 'organizations#alias', constraints: { id: /[0-9]+/ }
  get 'organizations/:id', to: 'organizations#show', as: 'organization_show_slug'
  get 'organization/:id', to: 'organizations#show', as: 'organization_slug'

  if Rails.env.development?
    get 'googleauth/start', to: 'google_auth#start'
    get 'googleauth/callback', to: 'google_auth#callback'
  end
end
