Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'weeks#index'
  get 'weeks', to: 'weeks#index'
  get 'week/:date', to: 'weeks#show', constraints: { date: /\d{4}-\d{2}-\d{2}/ }, as: :week
  resources :workouts, only: :create 
end
