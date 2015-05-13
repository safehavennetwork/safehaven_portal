Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root 'organization#dashboard'

  scope 'organization' do
    get 'sign-up/:type' => 'organization#sign_up_form'
    post 'sign-up/:type' => 'organization#sign_up'

    get ':id/new_client' => 'client#new_client_form'
    post ':id/new_client' => 'client#new'

    post 'accept-client/:id'  => 'organization#accept_client'
    post 'release-client/:id' => 'organization#release_client'
    post 'accept-pet/:id'     => 'organization#accept_pet'
    post 'release-pet/:id'    => 'organization#release_pet'
  end

  scope 'client' do
    get ':id'         => 'client#show'
    post ':id'         => 'client#update'
    post ':id/pets'    => 'client#pets'
    post ':id/delete'  => 'client#delete'
    post ':id/release' => 'client#release'
    post ':id/pet/new' => 'client#new_pet'
  end

  scope 'pet' do
    get ':id'        => 'pet#show'
    post ':id'        => 'pet#update'
    post ':id/delete' => 'pet#delete'
  end

  post 'toggle/:type/:id/:status' => 'organization#status_update'
end
