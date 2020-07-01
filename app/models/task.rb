class Task < ApplicationRecord

    belongs_to :user

    validates :task, presence: true, length: {minimum:4, maximum:20}
    validates :comments, presence: true, length: {minimum:4, maximum:1000}
end