Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: "quizzes#index"

  resources :quizzes do
    member do
      # results actions Kontrolierī GET apstrādās
      get 'results/:attempt_id', to: 'quizzes#results', as: 'results_attempt'
    end

    get 'search_quiz', on: :collection

    # Singular unit
    resource :quizlink, only: [:show, :create]

    resources :testimonials, only: [:index, :create, :destroy]
    resources :questions, shallow: true
  
    get 'play_quiz', on: :member
    post 'submit_quiz', on: :member
    get 'export_results', on: :member
    get 'export_scores', on: :member
    put 'publish', on: :member
  end
  resources :users, only: [:show]
  
  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check
end
