Rails.application.routes.draw do
  resources :tables

  root 'tables#index'
end
