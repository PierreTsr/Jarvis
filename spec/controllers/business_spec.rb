
require 'rails_helper'
RSpec.describe BusinessesController  do 
describe "get_business_detail" do 

    before :each do
        @data = {:id => 12, :name => 'Mexican', :category => 'Restaurant'}
    end

    it "show detail" do
        business = Business.new(@data)
        get :show, params:  {id:  business.id}
        expect(response).to render_template :show
    end

end 

end