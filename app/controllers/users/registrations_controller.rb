class Users::RegistrationsController < Devise::RegistrationsController
	before_action :configure_permitted_parameters

	def create
		params["user"] = params["user"].merge(session["user"])
		session.delete "user"
		super
	end

	def new
		unless (! session["user"].nil?) && (User.clean_answers session["user"])
			redirect_to questions_users_path
		else
			super
		end
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:from_country, :to_city, :work, :budget, :username])
	end

	def after_sign_up_path_for(resource)
		categories_path
	end

	def after_inactive_sign_up_path_for(resource)
		categories_path
	end
end
