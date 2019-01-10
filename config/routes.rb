Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :letters do
    member do
      post :to_cancel
      post :to_work
      post :to_completed
    end
    collection do
      get :letter_statistics
      get :search_email
    end
  end
  devise_for :users
  root 'letters#page'
end
