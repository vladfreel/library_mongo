Rails.application.routes.draw do
  devise_for :users
  resources :books do
    member do
      patch :update_status
      put :update_status
    end
    resources :histories
    resources :comments
    resources :likes
  end
  root to: "books#index"
end
