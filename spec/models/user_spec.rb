require 'rails_helper'

RSpec.describe User, type: :model do
  describe ":get_questions" do

    before :each do
      @questions = User.get_questions
    end

    it "is a Hash(Id,String)" do
      @questions.is_a? Hash
      @questions.each do |id, question|
        expect(id).to be_a Symbol
        expect(question).to be_a String
      end
    end

    it "matches the model attributes" do
      const_fields = [:id, :username, :email, :password_digest, :created_at, :updated_at]
      User.column_names do |id|
        expect(@question.keys).to include id unless const_fields.include? id
      end
    end
  end

  describe ":check_answers?" do

    before :each do
      @answers = {
        from_country: "France",
        to_city: "New York",
        work: 0,
        budget: 1
      }
    end

    it "accepts correct answers" do
      expect(User.check_answers? @answers).to be_truthy
    end

    User.get_questions.each_key do |key|
      it "rejects missing answer: #{key}" do
        @answers.delete key
        expect(User.check_answers? @answers).to be_falsey
      end
    end

    User.get_questions.each_key do |key|
      it "rejects wrong type: #{key}" do
        @answers[key] = 0
        int = User.check_answers? @answers
        @answers[key] = "abc"
        str = User.check_answers? @answers
        expect(str && int).to be_falsey
      end
    end
  end
end
