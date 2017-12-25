Rails.application.routes.draw do
  resources :books
  devise_for :users
  resources :books do
    resources :histories
    resources :comments
    resources :likes
  end
  root to: "books#index"
end
