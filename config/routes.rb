Rails.application.routes.draw do
  resources :tasks do
      patch :toggle_state
      patch :toggle_priority
  end
  root 'tasks#index'
end
