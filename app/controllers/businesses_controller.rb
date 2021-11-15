class BusinessesController < ApplicationController
  def index
    @categories = Business.new.get_all_categories
   
  end

  def recommendations
    @all_prices = {'$'=>"1",'$$' => "2",'$$$' => "3"}
    @all_ratings = {'1.0'=>1,'2.0' => 2,'3.0' => 3,'4.0' => 4,'5.0' => 5}
    #filters = filter_params


   
    if !params[:category].nil?
      @category = params[:category]
      zip_code = session[:zip_code] 
      
      if params[:prices]
        @prices_to_show = params[:prices] 
        session[:prices] = @prices_to_show
        @businesses = Business.new.get_business_from_category(@category, zip_code).with_prices(@prices_to_show.keys) 
      else
        @prices_to_show = session[:prices] || @all_prices
        @businesses = Business.new.get_business_from_category(@category, zip_code)
      end

      if params[:ratings]
        @ratings_to_show = params[:ratings] 
        session[:ratings] = @ratings_to_show
        @businesses = Business.new.get_business_from_category(@category, zip_code).with_ratings(@category,@ratings_to_show.keys) 
      else
        @ratings_to_show = session[:ratings] || @all_ratings
        @businesses = Business.new.get_business_from_category(@category, zip_code)
      end

    #  redirect_to recommendations_path(:category => @category, :ratings => @all_ratings, :prices => @all_prices)

  else
    redirect_to categories_path
  end

  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def filter_params
    params.require(:business).permit(:category, :rating, :price, :address)
  end

end

