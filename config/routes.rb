require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#home'
  resources :campaigns, except: [:new] do
    post 'raffle', on: :member
    # fica como /campaigns/:id/raffle
    
    # post 'raffle', on: :collection
    # fica como /campaigns/raffle
    
  end

  #URL de quando o cliente abriu o email
  get 'members/:token/opened', to: 'members#opened'
  resources :members, only: [:create, :destroy, :update]
end