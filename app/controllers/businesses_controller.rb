class BusinessesController < ApplicationController
  before_action :get_user_data

  def index
    @categories = Business.new.get_all_categories
  end

  def recommendations
    if !params[:category].nil?
      category = params[:category]
      zip_code = @user.zip_code if @user
      if zip_code
        @businesses = Business.new.get_business_from_category(category, zip_code)
        if(@businesses.length < 1)
          return "No businesses found"
        end
        cds = {'lat': session[:latitude].to_f, 'lng': session[:longitude].to_f}
        @distances = helpers.relative_distances_for_all_businesses(cds, @businesses)
        @businesses = @businesses.zip(@distances).sort_by{ |business,distance| distance}
      else
        redirect_to questions_users_path
      end
    else
      redirect_to categories_path
    end
  end

  protected

  def get_user_data
    if user_signed_in?
      @user = current_user
    elsif session["user"] && (User.clean_answers session["user"])
      @user = User.create_guest session["user"]
    else
      flash.alert = "Warning, you are not logged in and you haven't answered the questions."
    end
  end

end
