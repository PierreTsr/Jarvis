class Review < ApplicationRecord
  belongs_to :business
  belongs_to :user

  def get_rating(business_id)
    Review.where(:business_id => business_id).average(:rating)
  end

  def get_reviews(business_id)
    Review.where(:business_id => business_id)
  end
end
