class Review < ApplicationRecord
  belongs_to :business
  belongs_to :user

  def self.get_rating(business_id)
    Review.where(:business_id => business_id).average(:rating)
  end

  def self.get_reviews(business_id)
    Review.where(:business_id => business_id)
  end
end
