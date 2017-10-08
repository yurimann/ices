Rails.application.routes.draw do
  get 'details/index'

  get 'details/new'

  get 'details/create'

  get 'details/edit'

  get 'details/update'

  get 'details/delete'

  root to: "sales#index"
  resources :expenses
  resources :sales
  resources :ingredients
  resources :recipes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
