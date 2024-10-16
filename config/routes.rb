Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  root 'lessons#index'
  resources :lessons, only: %i[index show] do
    resources :lesson_dates, only: %i[index] do
      resources :reservations, only: %i[index create destroy]
    end
  end
  devise_for :users,
             controllers: { registrations: 'users/registrations' }
  namespace :admins do
    root 'lessons#index'
    resources :lessons do
      resources :lesson_dates, module: :lessons
    end
  end
  devise_for :admins
  get 'up' => 'rails/health#show', as: :rails_health_check
end
