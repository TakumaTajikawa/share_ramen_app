Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  root 'home#top'
  get :about, to: 'home#about'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  resources :users, only: [:show, :edit, :update]
  
end