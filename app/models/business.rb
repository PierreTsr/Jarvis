class Business < ApplicationRecord
  def get_business_from_category(category)
    Business.where(:category => category)
  end
end
