Rails.application.routes.draw do
  root 'posts#index'
  get :about, to: 'home#about'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resource :comments, only: [:create, :destroy]
  end
  
end