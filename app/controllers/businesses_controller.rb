class BusinessesController < ApplicationController
  def index
    @categories = Business.new.get_all_categories
   
  end

  def recommendations
    @all_prices = {'$'=>"1",'$$' => "2",'$$$' => "3", '$$$$' => "4"}
    @all_ratings = {'1.0'=>1,'2.0' => 2,'3.0' => 3,'4.0' => 4,'5.0' => 5}


   # if there is a category
    if !params[:category].nil?
      @category = params[:category]
      zip_code = session[:zip_code] 
      
      # if have prices filters
      if params[:prices]
        # puts params[:prices]
        @prices_to_show = params[:prices] 
        session[:prices] = @prices_to_show
        if params[:ratings] # prices filters and have ratings rilters
          @ratings_to_show = params[:ratings] 
          session[:ratings] = @ratings_to_show
          @businesses = Business.new.get_business_from_category(@category, zip_code).with_ratings_prices(@category,@ratings_to_show.keys,@prices_to_show.keys)
        else  # prices filters but no ratings filters
          @ratings_to_show = session[:ratings] || @all_ratings
          @businesses = Business.new.get_business_from_category(@category, zip_code).with_prices(@prices_to_show.keys) 
          
        end
      else # no prices filters
        @prices_to_show = session[:prices] || @all_prices
        if params[:ratings] # no prices filters but have ratings rilters
          @ratings_to_show = params[:ratings] 
          session[:ratings] = @ratings_to_show
          @businesses = Business.new.get_business_from_category(@category, zip_code).with_ratings(@category,@ratings_to_show.keys) 
        else  # no prices filters and no ratings filters
          @ratings_to_show = session[:ratings] || @all_ratings
          @businesses = Business.new.get_business_from_category(@category, zip_code)
        end
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

