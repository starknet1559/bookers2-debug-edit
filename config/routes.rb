Rails.application.routes.draw do
  get 'searches/search'
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about", as: 'home_about'
  get "/search", to: 'searches#search'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
  resource :favorites, only: [:create,:destroy]
  resources :book_comments, only: [:create,:destroy]
end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
end

  resources :messages, only: [:create]
  resources :romms, only: [:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
