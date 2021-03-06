class LeagueMatch < ApplicationRecord
  belongs_to :participant1, class_name: 'Participant'
  belongs_to :participant2, class_name: 'Participant'
  belongs_to :group

  def winner
    MatchResolver::GenericMatch.new(match: self).winner
  end
end
