Rails.application.routes.draw do
  get 'sales/range', to: 'sales#range', as: 'range'

  root to: "sales#index"
  resources :details
  resources :expenses
  resources :sales
  resources :ingredients
  resources :recipes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
