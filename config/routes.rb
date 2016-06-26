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

  resources :organizations, only: [:index, :show]
  resources :subscribers, only: [:create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'welcome#index'
  get 'about' => 'welcome#about'
  get 'events' => 'welcome#events'
  get 'conferences' => 'welcome#conferences'
  get 'bookings' => 'welcome#bookings'
  get 'live' => 'welcome#live'
  get 'fb_live' => 'welcome#fb_live'

  get 'videos/:tag', to: 'episodes#index', as: :tag
  get 'v/:id', to: 'episodes#alias', as: 'video'
  get 'video/*title--:id', to: 'episodes#show', as: 'video_slug'
  get ':id', to: 'episodes#show', as: 'video_shortcut', constraints: { id: /[0-9]+/ }

  get 'presenters', to: 'presenters#index', as: 'presenters'
  get 'presenters/:id', to: 'presenters#alias', as: 'presenter'
  get 's/:id', to: redirect('/presenter/%{id}'), as: 'speaker'
  get 'presenter/*name--:id', to: 'presenters#show', as: 'presenter_name_slug'
  get 'presenter/:id', to: 'presenters#slug', as: 'presenter_slug'

  get '/video/new-directions-in-cryptography-papers-we-love', to: redirect('/video/new-directions-in-cryptography-papers-we-love--601')

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
