Rails.application.routes.draw do
  devise_for :users

  root to: "quizzes#index"
  
  resources :quizzes do 
    resources :questions, shallow: true

    get 'play_quiz', on: :member
    post "submit_quiz", on: :member
    get 'results', on: :member
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
