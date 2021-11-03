require 'rails_helper'

RSpec.describe "Businesses", type: :request do
  describe "GET /businesses" do
    it "returns http success" do
      get "/categories"
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index
    end
  end
  describe "GET /recommendations" do
    it "returns http success on having category in params" do
      get "/recommendations", params: {:category => 'grocery'}
      expect(response).to have_http_status(:success)
      expect(response).to render_template :recommendations
    end
    it "redirects to businesses page on having category in params" do
      get "/recommendations"
      expect(response).to redirect_to('/categories')
    end
  end
end
