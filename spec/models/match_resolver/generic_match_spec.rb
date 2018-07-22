require 'rails_helper'

RSpec.describe MatchResolver::GenericMatch, type: :model do
  describe "Given a json score it returns the result" do
    it "identifies the participant with the highest score as the winner" do
      p1 = build(:participant, id: 1)
      p2 = build(:participant, id: 2)
      league_match = build(:league_match, score: { points: [4,5] }, participant1: p1, participant2: p2 )
      league = league_match.group.league

      resolver = MatchResolver::GenericMatch.new(match: league_match)

      expect(resolver.result).to eq(2)
      expect(resolver.winner).to eq(p2)
      expect(resolver.loser).to eq(p1)
      expect(resolver.league_points_for(participant_id: 1, league: league)).to eq(0)
      expect(resolver.league_points_for(participant_id: 2, league: league)).to eq(3)
    end
  end
  describe "Given no score" do
    it "returns an error of match not yet played" do
      league_match = build(:league_match)

      resolver = MatchResolver::GenericMatch.new(match: league_match)

      expect(resolver.result).to eq(0)
      expect(resolver.winner).to eq(nil)
      expect(resolver.loser).to eq(nil)
    end
  end

  describe "Given no league settings" do
    it "returns an error with no league settings" do
      league_match = build(:league_match)

      resolver = MatchResolver::GenericMatch.new(match: league_match)

      expect(resolver.result).to eq(0)
      expect(resolver.winner).to eq(nil)
      expect(resolver.loser).to eq(nil)
    end
  end
end