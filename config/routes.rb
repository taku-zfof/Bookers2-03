Rails.application.routes.draw do
  get 'rooms/show'
  get 'rooms/index'
  get 'relationships/fs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root:to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resources :book_comments,only: [:create,:destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create, :destroy]
    get :followings,on: :member
    get :followers, on: :member
  end
get "search"=>"searches#search" , as: "search"

resources :rooms, only: [:create, :index, :show]
resources :messages, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end