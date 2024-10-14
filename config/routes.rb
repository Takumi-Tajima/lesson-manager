Rails.application.routes.draw do
  devise_for :users
  namespace :admins do
    root 'lessons#index'
    resources :lessons
  end
  devise_for :admins
  get 'up' => 'rails/health#show', as: :rails_health_check
end
