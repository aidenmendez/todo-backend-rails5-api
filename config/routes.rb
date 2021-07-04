Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :todos
  match 'todos', to: 'todos#destroy_all', via: :delete
  root 'todos#index'

  resources :today, to: 'todos#today', only: [:index]
  resources :future, to: 'todos#future', only: [:index]
  resources :all_today, to: 'todos#all_today', only: [:index]
end
