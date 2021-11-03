class Business < ApplicationRecord
  def get_business_from_category(category)
    Business.where(:category => category)
  end
  
  def get_all_categories()
    Business.distinct(:category).pluck(:category)
  end
end
