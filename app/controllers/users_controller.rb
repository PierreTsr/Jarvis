class UsersController < ApplicationController

    def create
      answers = answers_params
      work_type = answers[:work].downcase
      answers[:work] = work_type == 'student' ? 0 : 1
      puts answers
      answers[:work] = Integer(answers[:work]) unless answers[:work].nil?
      answers[:budget] = Integer(answers[:budget]) unless answers[:budget].nil?      
      unless User.check_answers?(answers)
        flash.alert = "Sorry, we are unable to parse your answers. Please try again."
        #redirect_to questions_path
      else
        user = User.create_from_answers(answers)
        session[:zip_code] = answers[:to_city]
        redirect_to categories_path
      end
    end

    def questions
      puts User.get_questions
      @questions = User.get_questions
      @placeholders = User.get_placeholder_questions
    end 
    
    private

    def answers_params
      params.require(:user).permit(:from_country, :to_city, :work, :budget)
    end
end
