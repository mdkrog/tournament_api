class Participant < ApplicationRecord
  has_many :tournament_participants
  has_many :tournaments, through: :tournament_participants
  has_many :ladder_positions
  has_many :groups, through: :ladder_positions
  has_many :home_matches, :class_name => 'LeagueMatch', :foreign_key => 'participant1_id'
  has_many :away_matches, :class_name => 'LeagueMatch', :foreign_key => 'participant2_id'

  validates :name, presence: true

  def all_matches
    LeagueMatch.where(participant1_id: self.id).or(LeagueMatch.where(participant2_id: self.id))
  end
end
