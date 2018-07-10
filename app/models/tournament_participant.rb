class TournamentParticipant < ApplicationRecord
  belongs_to :participant
  belongs_to :tournament

  validates :participant_id, uniqueness: { scope: :tournament_id }
end
