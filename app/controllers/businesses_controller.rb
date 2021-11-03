class BusinessesController < ApplicationController
  def index
    @categories = Business.new.get_all_categories
  end

  def recommendations
    if !params[:category].nil?
      category = params[:category]
      @businesses = Business.new.get_business_from_category(category)
    else
      redirect_to categories_path
    end
  end

end
