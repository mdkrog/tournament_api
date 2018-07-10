class Tournament < ApplicationRecord
  validates_presence_of :name, :format
end
