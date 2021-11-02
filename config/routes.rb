Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#index"
  get 'user/questions', to: 'users#questions', as: 'questions'
  resource :user

end
