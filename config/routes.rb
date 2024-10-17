Rails.application.routes.draw do
  root 'lessons#index'
  devise_for :users,
             controllers: { registrations: 'users/registrations' }
  resources :my_reservations, only: %i[index show]
  resources :lessons, only: %i[index show] do
    resources :lesson_dates, only: %i[index] do
      resources :reservations, only: %i[create destroy]
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
