class UsersController < ApplicationController

    # def index
    # end

    def create
      answers = params[:answers]
      unless User.check_answers?(answers)
        redirect_to questions_path
        flash.alert = "Sorry, we are unable to parse your answers. Please try again."
      else
        User.create(answers)
        redirect_to dashboard_path
      end
    end

    def questions
      @questions = User.get_questions
    end 
end
