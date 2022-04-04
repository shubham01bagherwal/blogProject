Rails.application.routes.draw do
  # root path welcome index
  root 'sessions#new'

  # blogs all paths
  resources :blogs do

    # path for the comments
    resources :comments, only: [:create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    
    # path for the likes button
    resources :like, only: [ :create, :destroy]
    
  end

  # Extra paths
  get  'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get   'registrations/edit',   to: 'registrations#edit'
  patch 'registrations/update', to: 'registrations#update'


  get    'sign_in',  to: 'sessions#new'
  post   'sign_in',  to: 'sessions#create', as: 'log_in'
  delete 'logout',   to: 'sessions#destroy'
  get    'password', to: 'passwords#edit',  as: 'edit_password'
  patch  'password', to: 'passwords#update'
end
