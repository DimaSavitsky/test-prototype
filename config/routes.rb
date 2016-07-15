Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :administration do
    resources :tests
  end

  resources :tests

  root to: 'tests#index'

end
