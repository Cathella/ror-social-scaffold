Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :destroy]
  end

  put 'accept_request', to: 'friendships#accept'
  delete 'reject_request', to: 'friendships#reject'

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
