require 'securerandom'

class User < ApplicationRecord
	validates_presence_of :from_country, :address, :work, :budget, :zip_code, :latitude, :longitude
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
		latitude: "",
		longitude: ""
	}
	@@types = {
	 	from_country: :string,
    	address: :string,
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
		unless (answers.keys - @@types.keys).empty? and (@@questions.keys - answers.keys).empty?
			return nil
		end
		
		answers.each do |key, value|
			answers[key] = value.strip if value.acts_like? :string
		end
		
		answers[:work] = works[answers[:work].downcase.to_sym] if answers[:work].acts_like? :string
		answers[:budget] = Integer(answers[:budget]) rescue ""
		answers[:longitude] = Float(answers[:longitude]) rescue ""
		answers[:latitude] = Float(answers[:latitude]) rescue ""

		answers.each do |name, value|
			case @@types[name]
				when :string then
					return nil unless (value.is_a? String) && (value.length > 0)
				when :integer then
					return nil unless value.is_a? Integer
				when :float then
					return nil unless value.is_a? Float
			end
		end

		return answers
	end

	def self.infer_zip_code(answers)
		begin
			answers[:zip_code] = Integer(Geocoder.search([answers[:latitude].to_s, answers[:longitude].to_s]).first.postal_code)
		rescue
			return nil
		else
			return answers
		end
	end

	def self.clean_and_complete(answers)
		puts answers
		answers = self.clean_answers answers
		answers = self.infer_zip_code answers unless answers.nil?
		answers
	end

	def self.create_guest(answers)
		answers = self.clean_answers answers
		answers[:name] = "Guest"
		return User.new answers
	end
end
