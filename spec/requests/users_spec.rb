require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end

  describe "GET /questions" do

    it 'asks questions to the users' do
      expect(User).to receive(:get_questions).and_return({
        from_country: "Which country are you coming from?",
        to_city: "Which city are you going to?",
        budget: "What is your budget?"
      })
      get questions_path
      expect(response).to render_template(questions_path)
    end
  end

  describe "POST /create" do

    it "creates a new user if answers are OK" do
      answers = {
        from_country: "USA",
        to_city: "NYC",
        budget: 3
      }
      expect(User).to receive(:check_answers?)
      expect(User).to receive(:create)
      post users_path, params: { answers: answers }
      expect(response).to redirect_to(dashboard_path)
    end
    describe "doesn't create a new user when answers" do

      it "are empty" do
        answers = {
          from_country: "",
          to_city: "NYC",
          budget: 3
        }
        expect(User).to receive(:check_answers?)
        post users_path, params: { answers: answers }
        expect(response).to redirect_to(questions_path)
      end

      it "are incorrect" do
        answers = {
          from_country: "USA",
          to_city: "NYC",
          budget: "a"
        }
        expect(User).to receive(:check_answers?)
        post users_path, params: { answers: answers }
        expect(response).to redirect_to(questions_path)
      end
    end
  end
end
