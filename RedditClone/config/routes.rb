Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:index, :new, :create] do
    get "/content", to: 'posts#content'
  end
  resources :comments
end
