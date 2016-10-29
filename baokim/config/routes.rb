Rails.application.routes.draw do
  devise_for :users
  root "pay_requests#new"
  resources :pay_requests
end
