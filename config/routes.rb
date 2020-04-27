Rails.application.routes.draw do

  devise_for :admins, controllers: {
  	sessions: 'admins/users/sessions',
  	registrations: 'admins/users/registrations',
  	passwords: 'admins/users/passwords'
  }

  devise_for :end_users, controllers: {
  	sessions: 'customers/users/sessions',
  	registrations: 'customers/users/registrations',
  	passwords: 'customers/users/passwords'
  }

  namespace :admins do
    resources :items, :except => [:destroy]
    resources :genres, :except => [:show, :destroy]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
    resources :end_users, only: [:index, :show, :edit, :update]
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: :admins_about
  end

  scope module: :customers do
    resources :end_users, only: [:show, :edit, :update]
    get 'end_users/confirm' => 'end_users#confirm', as: :confirm
    resources :items, only: [:index, :show]
    delete 'cart_items/empty' => 'cart_items#empty', as: :empty
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :deliveries, :except => [:show]
    get 'orders/confirm' => 'orders#confirm', as: :orders_confirm
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks', as: :thanks
    resources :orders, only: [:index, :new, :create, :show]
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: :customers_about
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
