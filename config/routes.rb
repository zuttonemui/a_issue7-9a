Rails.application.routes.draw do
  get 'chat/show'
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  devise_for :users
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'folllowings' => 'relationships#followings', as: 'followings'
    get 'folllowers' => 'relationships#followers', as: 'followers'
    get 'search' => 'users#search'
  end
  resources :chats, only: [:show, :create]
  get 'search' => 'searches#search'
end
