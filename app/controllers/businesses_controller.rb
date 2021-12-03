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
      latitude = @user.latitude if @user
      longitude = @user.longitude if @user
      cds = {:lat => latitude.to_f, :lng => longitude.to_f}
      bounding_box = helpers.coordinates_to_miles(cds, 1)
      top_latitude = bounding_box[0]
      top_longitude = bounding_box[1]
      bottom_latitude = bounding_box[2]
      bottom_longitude = bounding_box[3]
      locations = {:top => [top_latitude, top_longitude], :bottom => [bottom_latitude, bottom_longitude]}
      @prices_to_show = @all_prices
      @ratings_to_show = @all_ratings
      if params[:prices]
        @prices_to_show = params[:prices]
      elsif session[:prices]
        @prices_to_show = session[:prices]
      end
      if params[:ratings]
        @ratings_to_show = params[:ratings]
      elsif session[:ratings]
        @ratings_to_show = session[:ratings]
      end
      session[:prices] = @prices_to_show
      session[:ratings] = @ratings_to_show
      @businesses = Business.businesses_with_ratings_prices(@category, @ratings_to_show.keys, @prices_to_show.keys, locations)
      coords = []
      @businesses.each_with_index do |cd, i| 
        cd_json = cd.as_json
        coos = [cd_json['latitude'], cd_json['longitude']]
        coords.push(coos)
      end
      # puts coords
      @distances = helpers.relative_distances_for_all_businesses(cds, coords)
      @businesses = @businesses.zip(@distances).sort_by{ |business,distance| distance}
    else
      redirect_to questions_users_path
    end
    #  redirect_to recommendations_path(:category => @category, :ratings => @all_ratings, :prices => @all_prices)
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

