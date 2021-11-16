class Business < ApplicationRecord
  def get_business_from_category(category, zip_code)
    zip_codes = [zip_code-1, zip_code, zip_code+1]
    zip_code_string = zip_codes.join(',')
    query = "SELECT * FROM businesses WHERE category = '#{category}' AND zip_code in (#{zip_code_string})"
    Business.find_by_sql(query)
    # Business.where(:category => category, :zip_code => zip_code)
  end
  
  def get_all_categories()
    Business.distinct(:category).pluck(:category)
  end

  
end
