class Business < ApplicationRecord
  # def get_business_from_category(category, coordinates)
  #   top_latitude, top_longitude = coordinates[:top]
  #   bottom_latitude, bottom_longitude = coordinates[:bottom]
  #   Business.where("category = ? AND latitude >= ? AND  latitude <= ? AND longitude >= ? AND longitude <= ?", category, top_latitude, bottom_latitude, top_longitude, bottom_longitude)
  #   # Business.where(:category => category, :zip_code => zip_code)
  # end
  
  def get_all_categories()
    Business.distinct(:category).pluck(:category)
  end

  # def self.businesses_with_prices(category, prices_list, coordinates)
  #     top_latitude, top_longitude = coordinates[:top]
  #     bottom_latitude, bottom_longitude = coordinates[:bottom]
  #   # if prices_list is an array retrieve all businesses with those prices
  #   # if prices_list is nil, retrieve ALL 
  #     if prices_list
  #       puts prices_list
  #       result = Business.find_by_sql(["SELECT * from businesses WHERE category = ? AND price IN (?) AND latitude >= ? AND  latitude <= ? AND longitude >= ? AND longitude <= ?", category, prices_list, top_latitude, bottom_latitude, top_longitude, bottom_longitude])
  #       puts result
  #       return result
  #       # return Business.find_by_sql(["SELECT * from businesses WHERE category = ? AND price IN (?) AND latitude >= ? AND  latitude <= ? AND longitude >= ? AND longitude <= ?", category, prices_list, top_latitude, bottom_latitude, top_longitude, bottom_longitude])
  #     # else
  #     #   return @businesses
  #     end
  #   end


  # def self.businesses_with_ratings(category, ratings_list, coordinates)
  #   top_latitude, top_longitude = coordinates[:top]
  #   bottom_latitude, bottom_longitude = coordinates[:bottom]
  #   # if ratings_list is an array retrieve all businesses with those ratings
  #   # if ratings_list is nil, retrieve ALL 
  #   if ratings_list
  #     #return Business.where(rating: ratings_list )
  #     new_rl = ratings_list.map { |rating| rating.to_f}
  #     return Business.find_by_sql(["SELECT * from businesses WHERE category = ? AND ROUND(rating) IN (?) AND latitude >= ? AND  latitude <= ? AND longitude >= ? AND longitude <= ?", category, new_rl, top_latitude, bottom_latitude, top_longitude, bottom_longitude])
  #   # else
  #   #   return @businesses
  #   end
  # end


def self.businesses_with_ratings_prices(category, ratings_list, prices_list, coordinates)
    top_latitude, top_longitude = coordinates[:top]
    bottom_latitude, bottom_longitude = coordinates[:bottom]
    if ratings_list and prices_list
      new_rl = ratings_list.map { |rating| rating.to_f}
      return Business.find_by_sql(["SELECT * from businesses WHERE category = ? AND price IN (?) AND ROUND(rating) IN (?) AND latitude >= ? AND  latitude <= ? AND longitude >= ? AND longitude <= ?", category, prices_list, new_rl, top_latitude, bottom_latitude, top_longitude, bottom_longitude])
    # else
    #   return @businesses
    end
  end
end
