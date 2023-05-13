Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users do 
    member do 
      get :confirm_email
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
