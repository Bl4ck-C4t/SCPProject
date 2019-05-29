Rails.application.routes.draw do
  get 'scp', to: 'scp#index'
  get 'scp/show'
  get 'scp/create'
  post 'scp/new'
  get 'scp/update'
  get 'scp/destroy'

  resources :staffs
  resources :monsters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
