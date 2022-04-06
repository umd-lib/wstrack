Rails.application.routes.draw do
  get 'workstation_availability/index'
  resources :locations
  resources :workstation_statuses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
