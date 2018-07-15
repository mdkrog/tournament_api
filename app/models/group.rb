class Group < ApplicationRecord
  belongs_to :league
  has_many :ladder_positions, dependent: :destroy
  has_many :participants, through: :ladder_positions
  has_many :league_matches, dependent: :destroy

  def get_ladder
    self.participants.each do |p|
      LadderPosition.recalculate_ladder_points(self, p)
    end
    LadderPosition.where(group: self).includes(:participant).order(points: :desc)
  end
end
