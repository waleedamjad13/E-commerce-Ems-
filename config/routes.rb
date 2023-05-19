Rails.application.routes.draw do
  root to: "products#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }

  resources :products, only: [:index, :show]

  namespace :admin do
    resources :categories
    
    resources :products do
      collection do
        get 'export', format: :csv
      end
    end
    resources :users do
      collection do
        get 'export', format: :csv
      end
    end

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
