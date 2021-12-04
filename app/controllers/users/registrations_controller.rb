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

	# PUT /resource
	# We need to use a copy of the resource because we don't want to change
	# the current user in place.
	def update
		self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
		prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

		account_update = account_update_params
		account_update = User.infer_zip_code account_update
		unless account_update
			redirect_to edit
			return
		end
		resource_updated = update_resource(resource, account_update)

		yield resource if block_given?
		if resource_updated
			set_flash_message_for_update(resource, prev_unconfirmed_email)
			bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

			respond_with resource, location: after_update_path_for(resource)
		else
			clean_up_passwords resource
			set_minimum_password_length
			respond_with resource
		end
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:from_country, :address, :work, :budget, :zip_code, :latitude, :longitude, :name])
		devise_parameter_sanitizer.permit(:account_update, keys: [:from_country, :address, :work, :budget, :zip_code, :latitude, :longitude, :name])
	end

	def after_sign_up_path_for(resource)
		categories_path
	end

	def after_inactive_sign_up_path_for(resource)
		categories_path
	end
end
