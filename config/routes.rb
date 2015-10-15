Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "organization#dashboard", as: :authenticated_root
  end

  unauthenticated do
    root to: "home#index"
  end

  scope 'legal' do
    get 'terms-of-use' => 'home#terms_of_use'
  end

  get 'live-search' => 'search#live_search'

  get  'getHelp'          => 'client#short_form'
  post 'anonymous-signup' => 'client#anonymous_signup'

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  scope 'organization' do
    get  ':id' => 'organization#show', as: 'organization'
    post ':id' => 'organization#update'
    post ':id/contact_info' => 'organization#update_contact_info'

    get  'sign-up/:type' => 'organization#sign_up_form'
    post 'sign-up/:type' => 'organization#sign_up'

    get  ':id/new_client' => 'client#new_client_form'
    post ':id/new_client' => 'client#new'

    post 'accept-client/:id'  => 'organization#accept_client'
    post 'release-client/:id' => 'organization#release_client'

    post 'accept-pets/:client_id' => 'organization#accept_pets'
    post 'release-pets/:client_id' => 'organization#release_pets'
  end

  scope 'client' do
    get  ':id'             => 'client#show', as: 'client'
    post ':id'             => 'client#update'
    post ':id/application' => 'client#client_application_update'
    post ':id/pets'        => 'client#pets'
    post ':id/delete'      => 'client#delete'
    post ':id/release'     => 'client#release'
    post ':id/pet/new'     => 'client#new_pet'
  end

  scope 'apply' do
    get  ''           => 'apply#new'

    get  'pet/:id'    => 'apply#pet', as: 'apply_pet_details'
    post 'pet/:id'    => 'apply#update_pet'

    get  'client/:id' => 'apply#client', as: 'apply_client_details'
    post 'client/:id' => 'apply#update_client_application'

    get  'review/:id'  => 'apply#review', as: 'application_review'
    post 'confirm/:id' => 'apply#confirm'
  end

  scope 'pet' do
    get ':id'         => 'pet#show'
    post ':id'        => 'pet#update'
    post ':id/delete' => 'pet#delete'
    post 'new/:id'    => 'pet#new_pet', as: 'new_pet'
  end

  post 'toggle/:type/:id/:status' => 'organization#status_update'

  scope 'user' do
    get  ':id' => 'users#show', as: 'user'
    post ':id' => 'users#update'
  end
end
