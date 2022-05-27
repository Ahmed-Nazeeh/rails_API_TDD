Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/articles', to: 'articles#index' #This only define the get or read action from the CRUD
  #resources :articles   # This will define all the CRUD actions automatically
  resources :articles, only: %i[index show]  #This will reveal only the index action
end
