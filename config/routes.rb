Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  get 'home', to: 'home#index', as: 'home'
  get 'all_users', to: 'users#index'

  resources :users, except: %i[index] do
    resources :books
  end
end
