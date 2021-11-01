class User < ApplicationRecord
  enum work: {student: 0, professional: 1}
end
