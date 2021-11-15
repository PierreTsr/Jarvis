class UsersController < ApplicationController

    def create
      answers = answers_params
      answers.each do |key, value| 
        answers[key] = value.strip
      end
      work_type = answers[:work].downcase unless answers[:work].nil?
      answers[:zip_code] = answers[:zip_code].to_i
      answers[:longitude] = answers[:longitude].to_f
      answers[:latitude] = answers[:latitude].to_f
      answers[:work] = work_type == 'student' ? 0 : 1 unless work_type.nil?
      answers[:budget] = Integer(answers[:budget]) if (answers[:budget].acts_like? :string) && answers[:budget].match(/^\s*\d+\s*$/)
      unless User.check_answers?(answers)
        flash.alert = "Sorry, we are unable to parse your answers. Please try again."
        redirect_to questions_path
      else
        user = User.create_from_answers(answers)
        puts answers
        session[:zip_code] = answers[:zip_code]
        redirect_to categories_path
      end
    end

    def questions
      @questions = User.get_questions
      @placeholders = User.get_placeholder_questions
      render :questions
    end 
    
    private

    def answers_params
      params.require(:user).permit(:from_country, :address, :work, :budget, :zip_code, :latitude, :longitude)
    end
end
