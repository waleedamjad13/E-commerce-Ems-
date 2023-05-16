Rails.application.routes.draw do
  root to: 'admin/users#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  namespace :admin do
    resources :users 
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
