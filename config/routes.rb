Rails.application.routes.draw do
  
  devise_for :users
  resources :cell_automatons do
    member do
      get :copy
    end
  end

  root 'cell_automatons#index'

end
