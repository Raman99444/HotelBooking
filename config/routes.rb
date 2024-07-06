Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  devise_scope :user do
    authenticated :user do
      root to: 'profiles#show', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end

    # temp signout route
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :bookings
  resource :profile, only: [:show, :edit, :update]

  get 'my_bookings', to: 'bookings#my_bookings', as: 'my_bookings'
end
