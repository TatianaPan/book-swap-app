Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  root 'home#index'
  get 'home', to: 'home#index', as: 'home'
  get 'users/sign_up', to: 'users/registrations#new'
  get 'users/sign_in', to: 'users/sessions#new'

  resources :users do
    resources :books
  end
end
