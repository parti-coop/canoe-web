Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy'
    if Rails.env.test?
      post '/users/sign_in', to: 'devise/sessions#create', as: :user_session
    end
  end
  root 'pages#home'

  resources :users
  resources :canoes do
    shallow do
      resources :discussions
      resources :sailing_diaries
      resources :memberships
    end
  end
  resources :boarding_requests do
    member do
      post 'accept'
    end
  end
  resources :opinions

  unless Rails.env.production?
    get 'kill_me', to: 'users#kill_me'
  end
end
