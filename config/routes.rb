Rails.application.routes.draw do
  root 'users/lessons#index'
  devise_for :users,
             controllers: { registrations: 'users/registrations' }
  resources :reservations, only: %i[index show], module: :users
  resources :lessons, module: :users, only: %i[index show] do
    resources :lesson_dates, module: :lessons, only: %i[index] do
      resource :reservation, only: %i[create destroy], module: :lesson_dates
    end
  end

  devise_for :admins
  namespace :admins do
    root 'lessons#index'
    resources :lessons do
      resources :lesson_dates, module: :lessons do
        resources :reserved_users, only: %i[index], module: :lesson_dates
      end
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
