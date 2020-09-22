Rails.application.routes.draw do
  root 'posts#index'
  get :about, to: 'home#about'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resource :relationships, only:[:create, :destroy]
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  get 'posts/:id/likes' => 'posts#likes'
  resources :notifications, only: :index
  delete 'destroy_all_notifications' => 'notifications#destroy_all'
  
end