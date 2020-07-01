class User < ApplicationRecord

    has_many :tasks
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :username, presence: true,
        length: {minimum: 3, maximum: 50},
        uniqueness: {case_sensitive: false}
    validates :email, presence: true,
        length: {maximum: 150}, 
        uniqueness: {case_sensitive: false},
        format: { with: VALID_EMAIL_REGEX }
end