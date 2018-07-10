class Tournament < ApplicationRecord
  has_many :tournament_participants
  has_many :participants, through: :tournament_participants

  validates :name, presence: true 
  validates :format, presence: true
end
