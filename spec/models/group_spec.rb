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

  describe "#get_ladder" do
    it "returns the ladder in order of points" do
      group = create(:group)
      p1 = create(:participant, name: "Red Team")
      p2 = create(:participant, name: "Blue Team")
      p3 = create(:participant, name: "Green Team")

      group.participants = [p1,p2,p3]

      create(:league_match, group: group, participant1: p1, participant2: p2, winner: 1)
      create(:league_match, group: group, participant1: p2, participant2: p3, winner: 2)
      create(:league_match, group: group, participant1: p1, participant2: p3, winner: 2)

      ladder = group.get_ladder

      expect(ladder.first.points).to eq(6)
      expect(ladder.first.participant.name).to eq("Green Team")
      expect(ladder.last.points).to eq(0)
      expect(ladder.last.participant.name).to eq("Blue Team")
    end
  end
end
