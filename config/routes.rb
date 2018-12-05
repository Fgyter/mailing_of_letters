Rails.application.routes.draw do
  devise_for :users
  resources :letters do
  end
end
