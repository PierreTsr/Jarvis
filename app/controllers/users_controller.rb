class UsersController < ApplicationController

    def create
      answers = answers_params
      puts answers
      answers[:work] = Integer(answers[:work]) unless answers[:work].nil?
      answers[:budget] = Integer(answers[:budget]) unless answers[:budget].nil?      
      unless User.check_answers?(answers)
        redirect_to questions_path
        flash.alert = "Sorry, we are unable to parse your answers. Please try again."
      else
        user = User.create_from_answers(answers)
        redirect_to dashboard_path(user.id)
      end
    end

    def questions
      @questions = User.get_questions
    end 
    
    private

    def answers_params
      params.require(:user).permit(:from_country, :to_city, :work, :budget)
    end
end
