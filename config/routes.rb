Rails.application.routes.draw do
  get 'businesses/', to:'businesses#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#index"
  get '/questions', to: 'users#questions', as: 'questions'
  get '/recommendations', to: 'users#recommendations', as: 'recommendations'
end
