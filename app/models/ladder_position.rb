class LadderPosition < ApplicationRecord
  belongs_to :participant
  belongs_to :group

  validates :participant_id, uniqueness: { scope: :group_id }

  def self.recalculate_ladder_points(group, participant)
    matches = participant.all_matches.where(group: group)
    points = matches.sum do |m|
      resolver = MatchResolver::GenericMatch.new(match: m)
      resolver.league_points_for(participant_id: participant.id, league: group.league)   
    end
    LadderPosition.where(group: group, participant: participant).first.update(points: points)
  end
end
