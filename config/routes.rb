Rails.application.routes.draw do

  devise_for :users
  resources :facilities
  resources :staffs
  resources :monsters
get 'scp', to: 'scp#index'
  get 'scp/show'
  get 'scp/create'
  post 'scp/new'
  get 'scp/edit'
  post 'scp/update'
  get 'scp/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
