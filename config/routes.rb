Rails.application.routes.draw do
  root 'home#top'
  get :about, to: 'home#about'
  devise_for :users
end
