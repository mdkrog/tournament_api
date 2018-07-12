require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:league) }
    it { is_expected.to have_many(:participants).through(:ladder_positions) }
    it { is_expected.to have_many(:league_matches) }

    it "destroys ladder_positions on delete but not associated participants" do
      group = create(:group)
      participant = create(:participant, groups: [group])

      group.destroy

      expect(LadderPosition.count).to eq(0)
      expect(Participant.count).to eq(1)
    end

    it "destroys matches on delete but not associated participants" do
      group = create(:group)
      league_match = create(:league_match, group: group)

      group.destroy

      expect(LeagueMatch.count).to eq(0)
    end
  end
end
