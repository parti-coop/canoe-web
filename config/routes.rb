Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'pages#home'

  resources :users
  resources :canoes do
    shallow do
      resources :discussions
      resources :sailing_diaries
    end
  end
  resources :boarding_requests
  resources :opinions
end
