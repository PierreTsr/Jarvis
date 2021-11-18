require 'rails_helper'

RSpec.describe User, type: :model do
  describe ":get_questions" do

    before :each do
      @questions = User.questions
    end

    it "is a Hash(Id,String)" do
      @questions.is_a? Hash
      @questions.each do |id, question|
        expect(id).to be_a Symbol
        expect(question).to be_a String
      end
    end
  end

  describe ":clean_answers" do

    before :each do
      @answers = {
        "from_country" => "France", 
        "address" => "1000 5th Ave, New York", 
        "work" => "student", 
        "budget" => 2,
        "zip_code" => 10028, 
        "latitude" => 40.779079, 
        "longitude" => -73.962578
      }
    end

    it "accepts correct answers" do
      expect(User.clean_answers @answers).to be_truthy
    end

    User.questions.each_key do |key|
      it "rejects missing answer: #{key}" do
        @answers.delete key.to_s
        expect(User.clean_answers @answers).to be_falsey
      end
    end

    User.questions.each_key do |key|
      it "rejects wrong type: #{key}" do
        @answers[key.to_s] = 0
        int = (User.clean_answers @answers).nil?
        @answers[key] = "abc"
        str = (User.clean_answers @answers).nil?
        expect(str || int).to be_truthy
      end
    end

    it "converts :work == \"student\" to 0" do
      @answers["work"] = "Student"
      @answers = User.clean_answers @answers
      expect(@answers).to be_truthy
      expect(@answers[:work]).to be 0
    end

    it "converts :work == \"professional\" to 1" do
      @answers["work"] = "Professional"
      @answers = User.clean_answers @answers
      expect(@answers).to be_truthy
      expect(@answers[:work]).to be 1
    end

    it "converts :budget to int" do
      @answers["budget"] = "100"
      @answers = User.clean_answers @answers
      expect(@answers).to be_truthy
      expect(@answers[:budget]).to be 100
    end
  end
end
