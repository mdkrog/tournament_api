require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:league) }
    it { is_expected.to have_many(:participants).through(:ladder_positions) }

    it "destroys ladder_positions on delete but not associated participants" do
      tournament = create(:tournament, format: 1)
      league = create(:league, tournament: tournament)
      group = create(:group, league: league)
      participant = create(:participant, name: 'Test')
      group.participants << participant

      group.destroy

      expect(LadderPosition.count).to eq(0)
      expect(Participant.count).to eq(1)
    end
  end
end
