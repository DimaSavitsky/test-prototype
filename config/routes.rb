Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
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

  resource :landing_page, only: [:show]
  resource :home, only: [:show]


  resource :profile, only: [:show, :edit, :update] do
    resources :test_results, only: [:show]

    resources :occupations, only: [:index] do
      collection do
        get :show_fake
      end
    end

    member do
      get :static_1
      get :static_2
      get :static_3
    end
  end

  resources :tests do
    resource :test_flow, only: [:show] do
      get :goto_question
      post :set_response
      post :finalize
    end
  end

  resources :trainings, only: [:index] do
    collection do
      get :show_fake
    end
  end

  resources :job_postings do
    collection do
      get :industry_occupations
      get :specifics
    end
  end

  resource :gap_report, only: [:show]

  resources :job_applications, only: [:index]
  resources :job_searches, only: [:index]

  resources :fake_job_postings, only: [:index] do
    collection do
      get :fake_new
      get :fake_preview
    end
  end

  root to: 'homes#show'

end
