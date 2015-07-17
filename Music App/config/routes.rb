Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users, only: [:create, :new, :show]

  resource :session, only: [:create, :new, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new]
end
