class Participant < ApplicationRecord
  has_many :tournament_participants
  has_many :tournaments, through: :tournament_participants
  has_many :ladder_positions
  has_many :groups, through: :ladder_positions

  validates :name, presence: true
end
