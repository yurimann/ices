Rails.application.routes.draw do


  get 'sales/range', to: 'sales#range', as: 'range'
  get 'expenses/range', to: 'expenses#range', as: 'expenses_range'
  get 'summary/write', to: 'summary#write_to_excel', as: 'write'
  get 'summary/write_expenses', to: 'summary#write_expenses', as: 'write_expenses'
  root to: "summary#index"
  resources :details
  resources :expenses
  resources :sales
  resources :ingredients
  resources :recipes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
