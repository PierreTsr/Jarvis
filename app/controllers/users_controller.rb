
class UsersController < ApplicationController

	def show
		redirect_to root_path
	end

	def answer
		begin
			answers[:zip_code] = Geocoder.search([answers[:latitude].to_s, answers[:longitude].to_s]).first.postal_code
			answers = answers_params
		rescue ActionController::UnpermittedParameters
			flash.alert = "Sorry, un-permitted parameters were provided. Please try again."
			redirect_to questions_users_path
		else
			answers = answers.to_h
			answers = User.clean_answers answers
			unless answers
				flash.alert = "Sorry, we were unable to parse your answers. Please try again."
				redirect_to questions_users_path
			else
				session[:user] = answers
				if params[:create_account]
					redirect_to new_user_registration_path
				else
					redirect_to categories_path
				end
			end
		end
	end

	def questions
		@questions = User.questions
		@placeholders = User.placeholders
		render :questions
	end

	private

	def answers_params
		ActionController::Parameters.action_on_unpermitted_parameters = :raise
		params.require(:user).permit(:from_country, :address, :work, :budget, :zip_code, :latitude, :longitude)
	end
end
