class Business < ApplicationRecord
  def get_business_from_category(category, zip_code)
    Business.where(:category => category, :zip_code => zip_code)
  end
  
  def get_all_categories()
    Business.distinct(:category).pluck(:category)
  end
end
