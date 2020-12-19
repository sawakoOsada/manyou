Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root 'tasks#index'
  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  end
end
