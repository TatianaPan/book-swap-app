Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home', to: 'home#index', as: 'home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
