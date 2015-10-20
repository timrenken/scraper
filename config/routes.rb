Rails.application.routes.draw do
  
  resources :movies
  root 'pages#home'

  devise_for :users
  
end
