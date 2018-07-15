class LeagueMatch < ApplicationRecord
  belongs_to :participant1, class_name: 'Participant'
  belongs_to :participant2, class_name: 'Participant'
  belongs_to :group

  def winning_participant
    return participant1 if self.winner == 1
    return participant2 if self.winner == 2
    return :draw if self.winner == 0
  end
end
