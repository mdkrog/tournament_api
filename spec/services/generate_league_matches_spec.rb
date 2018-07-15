require 'rails_helper'

RSpec.describe GenerateLeagueMatches, type: :service do
  
  describe "given group create matches where every one plays each other" do
    context "when 4 participants exist" do
      it "creates 6 matches with max of 2 games per round" do
        group = create_group_of_participants(4)

        match_generator = GenerateLeagueMatches.new
        matches = match_generator.generate(group: group, times_face_same_participant: 1)        
        rounds = matches.map { |m| m.round }.uniq

        expect(matches.length).to eq(6)
        rounds.each do |round|
          matches_in_round = matches.select { |m| m.round == round }.compact
          expect(matches_in_round.length <= 2).to be true
        end
      end
    end

    context "when 7 participants exist" do
      it "creates 21 matches with maximum of 3 games per round" do
        group = create_group_of_participants(7)

        match_generator = GenerateLeagueMatches.new
        matches = match_generator.generate(group: group, times_face_same_participant: 1)        
        rounds = matches.map { |m| m.round }.uniq

        expect(matches.length).to eq(21)
        rounds.each do |round|
          matches_in_round = matches.select { |m| m.round == round }.compact
          expect(matches_in_round.length <= 3).to be true
        end        
      end
    end

    context "when 3 participants exist" do
      it "creates 3 matches with maximum of 1 game per round" do
        group = create_group_of_participants(3)

        match_generator = GenerateLeagueMatches.new
        matches = match_generator.generate(group: group, times_face_same_participant: 1)        
        rounds = matches.map { |m| m.round }.uniq

        expect(matches.length).to eq(3)
        rounds.each do |round|
          matches_in_round = matches.select { |m| m.round == round }.compact
          expect(matches_in_round.length <= 1).to be true
        end
      end
    end

    it "generates equal home and away games" do
      group = create_group_of_participants(6)

      match_generator = GenerateLeagueMatches.new
      matches = match_generator.generate(group: group, times_face_same_participant: 2)        
      participant1_home_matches = matches.count { |m| m.participant1_id == 1 }
      participant1_away_matches = matches.count { |m| m.participant2_id == 1 }

      expect(matches.length).to eq(30)
      expect(participant1_away_matches).to eq(participant1_home_matches)
    end
  end

  def create_group_of_participants(number)
    group = create(:group)
    (1..number).each { |i| create(:participant, groups: [group]) }
    return group
  end
end