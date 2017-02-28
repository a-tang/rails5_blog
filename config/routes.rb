Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'signup', to: 'user#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root "home#home", as: :home
  get "/home" => "home#home"
  get "/about" => "home#about", as: :about_us
  resources :posts do
    resources :comments, only: [:create, :edit, :destroy, :update]
  end
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :users, only: [:new, :create, :edit, :update, :delete]
end
