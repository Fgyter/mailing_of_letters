Rails.application.routes.draw do
  resources :letters do
    member do
      post :to_cancel
      post :to_work
      post :to_completed
    end
  end
  devise_for :users
  root 'letters#page'
end
