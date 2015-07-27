Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :articles do
    resources :comments, only: [:create, :destroy, :update]
  end
  root 'welcome#index'
end
