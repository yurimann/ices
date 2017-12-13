Rails.application.routes.draw do
  get 'profits', to: 'profits#index', as: 'profits'

  get 'profits/month'

  get 'profits/year'

  root to: "summary#index"
  get 'sales/range', to: 'sales#range', as: 'range'
  get 'expenses/range', to: 'expenses#range', as: 'expenses_range'
  get 'summary/write', to: 'summary#write_to_excel', as: 'write'
  get 'summary/write_expenses', to: 'summary#write_expenses', as: 'write_expenses'
  post 'expenses/import', to: 'expenses#import_expenses_from_drive', as: 'import_expenses'
  post 'sales/import', to: 'sales#import_sales_from_drive', as: 'import_sales'

  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out

resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :details
  resources :expenses
  resources :sales
  resources :ingredients
  resources :recipes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
