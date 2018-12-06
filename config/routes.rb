Rails.application.routes.draw do
  resources :letters
  devise_for :users
  root 'letters#page'
end
