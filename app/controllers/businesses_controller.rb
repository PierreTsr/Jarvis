class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
    if !params[:category].nil?
      category = params[:category]
      @businesses = Business.new.get_business_from_category(category)
    end
    
  end
end
