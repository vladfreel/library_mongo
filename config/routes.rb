Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  default_url_options host: "localhost:3000"
  devise_for :users
  resources :books do
    resources :histories
    resources :comments
    resources :likes
  end
  root to: "books#index"
end
