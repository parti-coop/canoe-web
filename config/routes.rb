Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy'
  end
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
  unless Rails.env.production?
    get 'kill_me', to: 'users#kill_me'
  end
end
