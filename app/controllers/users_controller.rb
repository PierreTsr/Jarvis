class UsersController < ApplicationController

	def show
		redirect_to root_path
	end

	def answer
		answers = answers_params
		if !answers.permitted?
			flash.alert = "Sorry, un-permitted parameters were provided. Please try again."
			redirect_to questions_users_path
		else
			answers = answers.to_h
		end
		answers = User.clean_answers answers
		unless answers
			flash.alert = "Sorry, we were unable to parse your answers. Please try again."
			redirect_to questions_users_path
		else
			session[:zip_code] = answers[:to_city]
			session[:user] = answers
			if params[:create_account]
				redirect_to new_user_registration_path
			else
				redirect_to categories_path
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
		params.require(:user).permit(:from_country, :to_city, :work, :budget)
	end

end
