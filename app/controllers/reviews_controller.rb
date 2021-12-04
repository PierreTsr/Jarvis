class ReviewsController < ApplicationController
   
    def new 
        review_form_params = review_params
        puts review_form_params
        @review = Review.new(review_form_params)
        if !@review.save
            flash.alert = "Sorry, error saving your review. Please try again"      
        end
        redirect_back fallback_location: root_path
    end 


    def review_params
		ActionController::Parameters.action_on_unpermitted_parameters = :raise
		params.require(:review).permit(:rating, :title, :comment, :business_id, :user_id)
	end
end