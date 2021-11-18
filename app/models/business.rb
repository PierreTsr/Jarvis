class Business < ApplicationRecord
  def get_business_from_category(category, zip_code)
    zip_codes = [zip_code-1, zip_code, zip_code+1]
    zip_code_string = zip_codes.join(',')
    query = "SELECT * FROM businesses WHERE category = '#{category}' AND zip_code in (#{zip_code_string})"
    Business.where(:category => category , zip_code: zip_codes)
    # Business.find_by_sql(query)
    # Business.where(:category => category, :zip_code => zip_code)
  end
  
  def get_all_categories()
    Business.distinct(:category).pluck(:category)
  end

  def self.with_prices(prices_list)
    # if prices_list is an array retrieve all businesses with those prices
    # if prices_list is nil, retrieve ALL 
      if prices_list
        return Business.where(price: prices_list)
      # else
      #   return @businesses
      end
    end


  def self.with_ratings(category,ratings_list)
    # if ratings_list is an array retrieve all businesses with those ratings
    # if ratings_list is nil, retrieve ALL 
      if ratings_list
        #return Business.where(rating: ratings_list )
        new_rl = ratings_list.join(",")
        return Business.find_by_sql("SELECT * from businesses WHERE category = '#{category}' AND ROUND(rating) IN (#{new_rl}) ")
      # else
      #   return @businesses
      end
    end


def self.with_ratings_prices(category,ratings_list,prices_list)
    if ratings_list and prices_list
      new_rl = ratings_list.join(",")
      new_pl = "'#{prices_list.join("','")}'"
      return Business.find_by_sql("SELECT * from businesses WHERE category = '#{category}' AND price IN (#{new_pl}) AND ROUND(rating) IN (#{new_rl})")
    # else
    #   return @businesses
    end
  end
end
