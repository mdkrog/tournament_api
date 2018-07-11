class TournamentParticipant < ApplicationRecord
  belongs_to :participant
  belongs_to :tournament

  default_scope {order 'seeding ASC'}
  validates :participant_id, uniqueness: { scope: :tournament_id }
end
