Rails.application.routes.draw do

  devise_for :users
  resources :items do
    member do
      post :new_bid
    end
  end

  root to: 'items#index'

end
