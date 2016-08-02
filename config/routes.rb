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

  resource :profile, only: [:show, :edit, :update] do
    resources :test_results, only: [:show]
    resources :occupations, only: [:index]
  end

  resources :tests do
    resource :test_flow, only: [:show] do
      get :goto_question
      post :set_response
      post :finalize
    end
  end

  resources :job_postings do
    collection do
      get :industry_occupations
      get :specifics
    end
  end

  root to: 'profiles#show'

end
