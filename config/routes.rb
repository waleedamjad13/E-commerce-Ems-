Rails.application.routes.draw do
  root to: "products#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }

  resources :products, only: [:index, :show]
  

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
