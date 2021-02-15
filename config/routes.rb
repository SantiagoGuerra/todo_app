Rails.application.routes.draw do
  resources :todo_lists do
    resources :todo_items
  end
  namespace :todo_list do
    resources :todo_items
  end
  devise_for :users
  root to: "pages#home"

  get '/search', to: "pages#search"
end
