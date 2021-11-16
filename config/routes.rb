Rails.application.routes.draw do
	devise_for :users, controllers: { registrations: 'users/registrations', sessions: "users/sessions" }
	get '/categories', to: 'businesses#index'
	get '/recommendations', to: 'businesses#recommendations', as: 'recommendations'
  get 'business/:id', to: 'businesses#show', as: 'business_detail'
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	root "users#index"
	resources :users do
		collection do
			get 'questions', as: 'questions'
			post 'answer', as: 'answer'
		end
	end
end
