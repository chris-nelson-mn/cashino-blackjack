Rails.application.routes.draw do
  get 'players/action'

  resources :tables
  resources :players, only: [] do
    member do
      get :hit
      get :split
      get :stand
    end
  end

  root 'tables#index'
end
