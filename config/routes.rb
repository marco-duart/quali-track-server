Rails.application.routes.draw do
  resources :signatures
  resources :critical_fields
  resources :answers
  resources :questions
  resources :evaluations
  resources :teams
  devise_for :users

  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users, only: %i[index show create update destroy]

  resources :teams, only: %i[index show create update destroy]

  resources :evaluations do
    resources :evaluation_questions, only: %i[index create]
    resources :evaluation_critical_fields, only: %i[index create]
  end

  resources :questions, only: %i[show create update deactivate]

  resources :answers, only: %i[index show create update destroy]

  resources :critical_fields, only: %i[show create update deactivate]

  resources :signatures, only: %i[index show create update destroy]
end
