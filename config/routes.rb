Rails.application.routes.draw do
  devise_for :users

  root :to => 'root#index'

  resources :projects do
    resources :members, only: [:index]
    resources :tasks do
      put 'update_state', on: :member
    end
  end
  resources :users
  resources :archives, only: [:index, :show]
  resource :profile, only: [:show, :edit, :update]
end
