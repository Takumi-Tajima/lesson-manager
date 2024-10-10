Rails.application.routes.draw do
  namespace :admins do
    resources :lessons
  end
  devise_for :admins
  get 'up' => 'rails/health#show', as: :rails_health_check
end
