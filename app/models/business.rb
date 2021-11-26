class Business < ApplicationRecord
  def get_business_from_category(category, zip_code)
    zip_codes = [zip_code-1, zip_code, zip_code+1]
    Business.where(:category => category , :zip_code => zip_codes)
    # Business.where(:category => category, :zip_code => zip_code)
  end
  
  def get_all_categories()
    Business.distinct(:category).pluck(:category)
  end

  def self.with_prices(category, prices_list, zip_code)
    # if prices_list is an array retrieve all businesses with those prices
    # if prices_list is nil, retrieve ALL 
    zip_codes = [zip_code-1, zip_code, zip_code+1]
      if prices_list
        return Business.find_by_sql(["SELECT * from businesses WHERE category = ? AND price IN (?) AND zip_code IN (?)", category, prices_list, zip_codes])
      # else
      #   return @businesses
      end
    end


  def self.with_ratings(category, ratings_list, zip_code)
    # if ratings_list is an array retrieve all businesses with those ratings
    # if ratings_list is nil, retrieve ALL 
    zip_codes = [zip_code-1, zip_code, zip_code+1]
    if ratings_list
      #return Business.where(rating: ratings_list )
      new_rl = ratings_list.map { |rating| rating.to_f}
      return Business.find_by_sql(["SELECT * from businesses WHERE category = ? AND ROUND(rating) IN (?) AND zip_code IN (?)", category, new_rl, zip_codes])
    # else
    #   return @businesses
    end
  end


def self.with_ratings_prices(category, ratings_list, prices_list, zip_code)
    if ratings_list and prices_list
      zip_codes = [zip_code-1, zip_code, zip_code+1]
      new_rl = ratings_list.map { |rating| rating.to_f}
      return Business.find_by_sql(["SELECT * from businesses WHERE category = ? AND price IN (?) AND ROUND(rating) IN (?) AND zip_code IN (?)", category, prices_list, new_rl, zip_codes])
    # else
    #   return @businesses
    end
  end
end
