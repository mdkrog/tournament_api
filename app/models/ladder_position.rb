class LadderPosition < ApplicationRecord
  belongs_to :participant
  belongs_to :group

  validates :participant_id, uniqueness: { scope: :group_id }

  def self.recalculate_ladder_points(group, participant)
    matches = participant.all_matches.where(group: group)
    points = 0
    matches.each do |m|
      points += 3 if participant == m.winning_participant
      points += 1 if m.winning_participant == :draw
    end
    LadderPosition.where(group: group, participant: participant).first.update(points: points)
  end
end
