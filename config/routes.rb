Rails.application.routes.draw do
  
  devise_for :users
  resources :cell_automatons

  root 'cell_automatons#index'

end
