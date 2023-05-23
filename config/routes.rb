Rails.application.routes.draw do
  root to: "products#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }

  resources :products, only: [:index, :show]

  get 'carts/:id', to: "carts#show", as: "cart"
  delete 'carts/:id', to: "carts#destroy"

  post 'order_items', to: "order_items#create"
  get 'order_items/:id', to: "order_items#show", as: "order_item"
  delete 'order_items/:id', to: "order_items#destroy"

  post 'order_items/:id/add', to: "order_items#add_quantity", as: "order_item_add"
  post 'order_items/:id/reduce', to: "order_items#reduce_quantity", as: "order_item_reduce"

  namespace :admin do
    resources :discounts do 
      collection do
        get 'export', format: :csv
      end
    end

    resources :categories
    get 'sort/:column(/:direction)', to: 'categories#index', as: 'sort'

    resources :products do
      collection { get 'export', format: :csv }
      get 'sort/:column(/:direction)', on: :collection, action: :index, as: 'sort'
    end
    
    resources :users do
      collection { get 'export', format: :csv }
      get 'sort/:column(/:direction)', action: :index, on: :collection, as: 'sort_users'
    end

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
