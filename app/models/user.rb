require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  enum work: { student: 0, professional: 1 }

  def self.get_questions
    return {
      from_country: "Which country are you coming from?",
      to_city: "Which city are you traveling to?",
      work: "What is your work category?",
      budget: "What is your budget"
    }
  end

  def self.get_placeholder_questions
    return {
      from_country: "India",
      to_city: "10025",
      work: "Student/Professional",
      budget: "2000"
    }
  end
  
  def self.check_answers?(answers)
    unasked_fields = [:id, :username, :email, :password_digest, :created_at, :updated_at]
    User.columns_hash.each do |name, v|
      type = v.type
      name = name.to_sym
      next if unasked_fields.include? name

      if answers[name].nil? or answers[name] == ""
        return false
      end

      case type
      when :string then
        return false unless answers[name].is_a? String
      when :integer then
        return false unless answers[name].is_a? Integer
      when :integer then
        return false unless answers[name].is_a? DateTime
      else
        puts "Warning", type.class
      end
    end

    return true
  end

  def self.create_from_answers(answers)
    answers[:username] = SecureRandom.uuid
    answers[:password_digest] = "tmp" #TODO: fix that
    answers[:email] = ""
    return self.create!(answers)
  end
end
