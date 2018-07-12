class Group < ApplicationRecord
  belongs_to :league
  has_many :ladder_positions, dependent: :destroy
  has_many :participants, through: :ladder_positions
  has_many :league_matches, dependent: :destroy
end
