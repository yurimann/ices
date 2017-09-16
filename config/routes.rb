Rails.application.routes.draw do
  root to: "sales#new"
  resources :expenses
  resources :sales
  resources :ingredients
  resources :recipes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
