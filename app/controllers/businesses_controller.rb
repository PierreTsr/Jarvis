class BusinessesController < ApplicationController
  def index
    @categories = Business.new.get_all_categories
  end

  def recommendations
    if !params[:category].nil?
      category = params[:category]
      zip_code = session[:zip_code] 
      @businesses = Business.new.get_business_from_category(category, zip_code)
    else
      redirect_to categories_path
    end
  end

end
