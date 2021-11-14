require 'securerandom'

class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :validatable
	enum work: { student: 0, professional: 1 }

	cattr_reader :questions, :types, :placeholders
	@@questions = {
	  from_country: "Which country are you coming from?",
	  to_city: "Which city are you traveling to?",
	  work: "What is your work category?",
	  budget: "What is your budget?"
	}
	@@types = {
	  from_country: :string,
	  to_city: :string,
	  work: :integer,
	  budget: :integer
	}
	@@placeholders = {
	  from_country: "India",
	  to_city: "10025",
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
		answers[:budget] = Integer(answers[:budget]) if (answers[:budget].acts_like? :string) && answers[:budget].match(/^\s*\d+\s*$/)
		@@types.each do |name, type|
			case type
				when :string then
					return nil unless answers[name].is_a? String
				when :integer then
					return nil unless answers[name].is_a? Integer
				else
					puts "Warning", type.class
			end
		end

		return answers
	end

	def self.create_guest(answers)
		answers = self.clean_answers answers
		answers[:username] = "Guest"
		return User.new answers
	end
end
