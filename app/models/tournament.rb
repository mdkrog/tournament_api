class Tournament < ApplicationRecord
  validates :name, presence: true 
  validates :format, presence: true
end
