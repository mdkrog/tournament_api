require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe "fields and validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:tournaments).through(:tournament_participants) }
    it { is_expected.to have_many(:groups).through(:ladder_positions) }
    it { is_expected.to have_many(:home_matches) }
    it { is_expected.to have_many(:away_matches) }
  end

  describe "#all_matches" do
    it "returns all matches that the participant involved in" do
      player1 = create(:participant)

      create(:league_match, participant1: player1)
      create(:league_match, participant2: player1)

      expect(player1.all_matches.count).to eq(2)
    end
  end
end
