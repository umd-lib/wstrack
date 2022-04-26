Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  post 'users/auth/:provider/callback', to: 'sessions#create', as: 'auth_callback'
  get '/login', to: 'sessions#new', as: 'login'

  get 'availability' => "workstation_availability#index"
  get 'availability/list' => "workstation_availability#index"
  resources :locations
  resources :workstation_statuses

  # Rails by default does not allow dot '.' character in URL.
  # Adding a constraint that allows dot will overcome this issue.
  # Here we have added a constraint that allows anything except forward-slash '/'
  get 'track/:workstation_name/:status/:os/:guest_flag/:user_hash' => 'workstation_statuses#update_status',
      :constraints => { os: %r{[^\/]+} },
      as: 'wstrack_client'

  get '/ping' => 'ping#verify'
end
