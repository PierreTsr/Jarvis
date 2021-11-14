require 'rails_helper'

RSpec.describe "Users", type: :request do

	describe "GET /questions" do

		it 'asks questions to the users' do
			expect(User).to receive(:questions).and_return({
															 from_country: "Which country are you coming from?",
															 to_city: "Which city are you going to?",
															 budget: "What is your budget?"
														   })
			get questions_users_path
			expect(response).to render_template(:questions)
		end
	end

	describe "POST /answer" do

		it "redirects to sign up if answers are OK and :create_account" do
			answers = {
			  from_country: "USA",
			  to_city: "NYC",
			  work: "student",
			  budget: "3"
			}
			expect(User).to receive(:clean_answers).and_return(answers)
			post answer_users_path, params: { user: answers, create_account: "true" }
			expect(response).to redirect_to(new_user_registration_path)
		end

		it "redirects categories if answers are OK and not :create_account" do
			answers = {
			  from_country: "USA",
			  to_city: "NYC",
			  work: "student",
			  budget: "3"
			}
			expect(User).to receive(:clean_answers).and_return(answers)
			post answer_users_path, params: { user: answers }
			expect(response).to redirect_to(categories_path)
		end

		describe "doesn't create a new user when answers" do

			it "are empty" do
				answers = {
				  from_country: "",
				  to_city: "NYC",
				  budget: 3
				}
				expect(User).to receive(:clean_answers).and_return(nil)
				post answer_users_path, params: { user: answers }
				expect(response).to redirect_to(questions_users_path)
			end

			it "are incorrect" do
				answers = {
				  from_country: "USA",
				  to_city: "NYC",
				  budget: "a"
				}
				expect(User).to receive(:clean_answers).and_return(nil)
				post answer_users_path, params: { user: answers }
				expect(response).to redirect_to(questions_users_path)
			end

			it "are unpermitted" do
				answers = {
				  from_country: "USA",
				  to_city: "NYC",
				  work: "student",
				  budget: "3",
				  hack: true
				}
				post answer_users_path, params: { user: answers }
				expect(response).to redirect_to(questions_users_path)
			end
		end
	end
end
