Rails.application.routes.draw do
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
    get "search_record" => "searches#search_record",as: "search_record"
  end
  
get "search"=>"searches#search" , as: "search"

resources :rooms, only: [:create, :index, :show]
resources :messages, only: [:create]

get "groups/create_form"=> "groups#create_form", as: "group_create_form"

resources :groups, only: [:index, :show, :create, :edit,:destroy]do
  resources :events, only: [:create,:new] do
  get "done" => "events#done", as: "done"
 end
end

resources :group_users, only: [:create,:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end