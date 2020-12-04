Rails.application.routes.draw do
  resources :tasks do
      patch :toggle_state
  end
  root 'tasks#index'
end
