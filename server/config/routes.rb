Rails.application.routes.draw do
  resources :locations
  resources :workstation_statuses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
