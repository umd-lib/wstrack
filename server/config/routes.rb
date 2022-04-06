Rails.application.routes.draw do
  get 'availability' => "workstation_availability#index"
  get 'availability/list' => "workstation_availability#index"
  resources :locations
  resources :workstation_statuses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
