Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  default_url_options host: "localhost:3000"
  devise_for :users
  resources :books do
    member do
      patch :update_status_in
      put :update_status_in
      patch :update_status_out
      put :update_status_out
    end
    resources :histories
    resources :comments
    resources :likes
  end
  root to: "books#index"
end
