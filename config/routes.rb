Rails.application.routes.draw do
  resources :tasks
  root to: 'task#index'
end
