require 'securerandom'

class User < ApplicationRecord
	validates_presence_of :from_country, :to_city, :work, :budget
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :validatable
	enum work: { student: 0, professional: 1 }

	cattr_reader :questions, :types, :placeholders
	@@questions = {
    from_country: "Which country are you coming from?",
    address: "Which city are you traveling to?",
    work: "What is your work category?",
    budget: "What is your budget?",
    zip_code: "",
    latitude: "",
    longitude: ""
  }
	@@types = {
	  from_country: :string,
    address: :string
	  work: :integer,
	  budget: :integer,
    zip_code: :integer,
    latitude: :float,
    longitude: :float
	}
	@@placeholders = {
	  from_country: "India",
	  address: "2960 Broadway",
	  work: "Student/Professional",
	  budget: "2000"
	}

	def self.clean_answers(answers)
		answers = answers.symbolize_keys
		unless answers.size == @@questions.size and (answers.keys - @@questions.keys).empty?
			return nil
		end

		answers.each do |key, value|
			answers[key] = value.strip if value.acts_like? :string
		end
    
		answers[:work] = works[answers[:work].downcase.to_sym] if (answers[:work].acts_like? :string)
		answers[:budget] = answers[:budget].to_i if (answers[:budget].acts_like? :string)
    answers[:zip_code] = answers[:zip_code].to_i if (answers[:zip_code].acts_like? :string)
    answers[:longitude] = answers[:longitude].to_f if (answers[:longitude].acts_like? :string)
    answers[:latitude] = answers[:latitude].to_f if (answers[:latitude].acts_like? :string)

		@@types.each do |name, type|
			case type
				when :string then
					return nil unless (answers[name].is_a? String) && (answers[name].length > 0)
				when :integer then
					return nil unless answers[name].is_a? Integer
        when :float then
          return nul unless answers[name].is_a? Float
			end
		end

		return answers
	end

	def self.create_guest(answers)
		answers = self.clean_answers answers
		answers[:name] = "Guest"
		return User.new answers
	end
end
