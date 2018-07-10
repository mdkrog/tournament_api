class Participant < ApplicationRecord
  has_many :tournament_participants
  has_many :tournaments, through: :tournament_participants

  validates :name, presence: true
end
