class Student < ApplicationRecord
    validates :name, presence: true
    validates :age, numericality: { greater_than: 18 }

    belongs_to :instructor
end
