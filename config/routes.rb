Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  devise_for :users
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'folllowings' => 'relationships#followings', as: 'followings'
    get 'folllowers' => 'relationships#followers', as: 'followers'
    get 'search' => 'users#search'
  end
  get 'search' => 'searches#search'
  get 'tag_search' => 'books#tag_search'
  resources :chats, only: [:show, :create]
  resources :groups do
    get 'join' => 'groups#join'
    get 'new/mail' => 'groups#new_mail'
    get 'send/mail' => 'groups#send_mail'
  end
end
