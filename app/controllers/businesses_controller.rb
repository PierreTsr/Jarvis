class BusinessesController < ApplicationController
  def index
    @categories = Business.new.get_all_categories
  end

  def recommendations
    if !params[:category].nil?
      category = params[:category]
      zip_code = session[:zip_code] 
      @businesses = Business.new.get_business_from_category(category, zip_code)
      if(@businesses.length < 1) 
        return "No businesses found"
      end
      cds = {'lat': session[:latitude].to_f, 'lng': session[:longitude].to_f}
      @distances = helpers.relative_distances_for_all_businesses(cds, @businesses)
      @businesses = @businesses.zip(@distances).sort_by{ |business,distance| distance}
    else
      redirect_to categories_path
    end
  end

end
