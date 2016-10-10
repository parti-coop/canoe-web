Rails.application.routes.draw do
  mount RootAPI, at: '/'
  mount GrapeSwaggerRails::Engine => '/docs'

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
          patch :archive
          patch :inbox
        end
        resources :consensus_revisions
        resources :proposal_requests do
          member do
            patch :archive
            patch :inbox
          end
        end
        resources :opinions do
          resources :comments
        end
      end
      resources :sailing_diaries do
        resources :comments
      end
      resources :wikis
      resources :memberships do
        delete :cancel, on: :collection
      end
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
      delete 'vote', to: 'votes#unvote'
    end
  end

  unless Rails.env.production?
    get 'kill_me', to: 'users#kill_me'
  end
end
