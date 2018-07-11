require 'rails_helper'

RSpec.describe League, type: :model do
  describe "fields and validations" do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to have_many(:groups) }
    it { is_expected.to respond_to(:number_of_groups) }

    it "destroys groups on delete" do
      tournament = create(:tournament, format: 1)
      league = create(:league, tournament: tournament)
      group = create(:group, league: league)

      league.destroy

      expect(Group.count).to eq(0)
    end
  end  
end
