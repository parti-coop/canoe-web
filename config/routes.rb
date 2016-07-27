Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'pages#home'

  resources :canoes do
    resources :discussions
    resources :sailing_diaries
  end
  resources :boarding_requests
end
