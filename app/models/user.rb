class User < ApplicationRecord
  has_secure_password
  enum work: {student: 0, professional: 1}
end
