Rails.application.routes.draw do
  devise_for :users
  root to: "weeks#index"
  resource :weeks
end
