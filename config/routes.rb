Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  root 'lessons#index'
  resources :lessons, only: %i[index show]
  devise_for :users,
             controllers: { registrations: 'users/registrations' }
  namespace :admins do
    root 'lessons#index'
    resources :lessons
  end
  devise_for :admins
  get 'up' => 'rails/health#show', as: :rails_health_check
end
