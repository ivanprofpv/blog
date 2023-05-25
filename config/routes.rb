Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :posts do
    resources :comments, only: %i[create edit update destroy]
  end


  root "posts#index"
  get '/my', to: 'posts#user_post'
end
