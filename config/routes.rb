Rails.application.routes.draw do
  get '/categories', to:'businesses#index'
  get '/recommendations', to: 'businesses#recommendations', as: 'recommendations'
  get 'business/:id', to: 'businesses#show', as: 'business_detail'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#index"
  get 'users/questions', to: 'users#questions', as: 'questions'
  resources :users

end
