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
    get '/categories/:category_id/discussions', to: 'discussions#index', as: :category
    shallow do
      resources :categories
      resources :discussions do
        member do
          get :edit_consensus
          patch :consensus
        end
        resources :consensus_revisions
        resources :proposal_requests
        resources :opinions
      end
      resources :sailing_diaries
      resources :memberships
    end
  end
  resources :boarding_requests do
    member do
      post 'accept'
    end
  end
  resources :proposals do
    member do
      post 'agree', to: 'votes#agree'
      post 'block', to: 'votes#block'
    end
  end

  unless Rails.env.production?
    get 'kill_me', to: 'users#kill_me'
  end
end
