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
			@user_data = {name: "Pierre", from_country: "France", address: "1000 5th Ave, New York", work: "student", budget: 2, email: "test@mail.com", password: "lalala", zip_code: 10028, latitude: 40.779079, longitude: -73.962578}
			sign_in User.new(@user_data)
			get "/recommendations", params: { :category => 'groceries' }
			expect(response).to have_http_status(:success)
			expect(response).to render_template :recommendations
		end
		it "redirects to businesses page on having category in params" do
			get "/recommendations"
			expect(response).to redirect_to('/categories')
		end
	end
	describe "get_user_data" do
		before :each do
			@user_data = {name: "Pierre", from_country: "France", address: "1000 5th Ave, New York", work: "student", budget: 2, email: "test@mail.com", password: "lalala", zip_code: 10028, latitude: 40.779079, longitude: -73.962578}
		end
		it "gets the current signed in user" do
			user = User.new(@user_data)
			sign_in user
			get categories_path
		end
	end
end
