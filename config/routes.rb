Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :administration do
    resources :tests do
      resources :questions, except: [:index, :show]
      resources :test_variables, only: [] do
        resource :test_result, only: [:edit, :update]
      end
      member do
        put :publish
        patch :publish
      end
    end
  end

  resource :profile, only: [:show]
  resources :tests

  root to: 'profile#show'

end
