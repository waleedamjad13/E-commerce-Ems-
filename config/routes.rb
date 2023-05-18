Rails.application.routes.draw do
  root to: "products#index"
  resources :products, only: [:index]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  namespace :admin do
    root to: 'admin/users#index'

    resources :products
    resources :users do
      collection do
        get 'export', format: :csv
      end
    end

  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
