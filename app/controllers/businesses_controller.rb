class BusinessesController < ApplicationController
  before_action :get_user_data

  def index
    @categories = Business.new.get_all_categories
   
  end

  def recommendations
    @all_prices = {'$'=>"1",'$$' => "2",'$$$' => "3", '$$$$' => "4"}
    @all_ratings = {'1.0'=>1,'2.0' => 2,'3.0' => 3,'4.0' => 4,'5.0' => 5}


   # if there is a category
    if !params[:category].nil?
      @category = params[:category]
      zip_code = @user.zip_code if @user
      
      if zip_code
        cds = {'lat': session[:latitude].to_f, 'lng': session[:longitude].to_f}
        # if have prices filters
        if params[:prices]
          # puts params[:prices]
          @prices_to_show = params[:prices] 
          session[:prices] = @prices_to_show
          if params[:ratings] # prices filters and have ratings rilters
            @ratings_to_show = params[:ratings] 
            session[:ratings] = @ratings_to_show
            @businesses = Business.new.get_business_from_category(@category, zip_code).with_ratings_prices(@category,@ratings_to_show.keys,@prices_to_show.keys)
            # if(@businesses.length < 1)
            #   return "No businesses found"
            # end
            @distances = helpers.relative_distances_for_all_businesses(cds, @businesses)
            @businesses = @businesses.zip(@distances).sort_by{ |business,distance| distance}
          else  # prices filters but no ratings filters
            @ratings_to_show = session[:ratings] || @all_ratings
            @businesses = Business.new.get_business_from_category(@category, zip_code).with_prices(@prices_to_show.keys) 
            # if(@businesses.length < 1)
            #   return "No businesses found"
            # end
            @distances = helpers.relative_distances_for_all_businesses(cds, @businesses)
            @businesses = @businesses.zip(@distances).sort_by{ |business,distance| distance}
          end
        else # no prices filters
          @prices_to_show = session[:prices] || @all_prices
          if params[:ratings] # no prices filters but have ratings rilters
            @ratings_to_show = params[:ratings] 
            session[:ratings] = @ratings_to_show
            @businesses = Business.new.get_business_from_category(@category, zip_code).with_ratings(@category,@ratings_to_show.keys) 
            # if(@businesses.length < 1)
            #   return "No businesses found"
            # end
            @distances = helpers.relative_distances_for_all_businesses(cds, @businesses)
            @businesses = @businesses.zip(@distances).sort_by{ |business,distance| distance}
          else  # no prices filters and no ratings filters
            @ratings_to_show = session[:ratings] || @all_ratings
            @businesses = Business.new.get_business_from_category(@category, zip_code)
            # if(@businesses.length < 1)
            #   return "No businesses found"
            # end
            @distances = helpers.relative_distances_for_all_businesses(cds, @businesses)
            @businesses = @businesses.zip(@distances).sort_by{ |business,distance| distance}
          end
        end
      else
        redirect_to questions_users_path
      end
    #  redirect_to recommendations_path(:category => @category, :ratings => @all_ratings, :prices => @all_prices)
    else
      redirect_to categories_path
    end
  end

  def show
    id = params[:id]
    @business = Business.find(id)
    @rating = Review.get_rating(id)
    @reviews = Review.get_reviews(id).order(created_at: :desc).paginate(page: params[:page], per_page: 2)
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


  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def filter_params
    params.require(:business).permit(:category, :rating, :price, :address)
  end

end

