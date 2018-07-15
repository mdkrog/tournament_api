require 'rails_helper'

RSpec.describe LadderPosition, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to belong_to(:participant) }
    it { is_expected.to respond_to(:position) }
    it { is_expected.to respond_to(:points) }
  end

  describe "#recalculate_ladder_points" do
    it "updates points for participant in group" do
      group = create(:group)
      p1 = create(:participant, name: "Red Team")
      lp = create(:ladder_position, group: group, participant: p1)

      create(:league_match, group: group, participant1: p1, winner: 1)
      create(:league_match, group: group, participant1: p1, winner: 0)
      create(:league_match, group: group, participant1: p1, winner: 1)

      LadderPosition.recalculate_ladder_points(group,p1)

      expect(lp.reload.points).to eq(7)
    end
  end
end
