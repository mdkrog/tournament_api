require 'rails_helper'

RSpec.describe GenerateLeague, type: :service do
  describe "given a tournament it must create an associated league" do
    it "creates a league with only 1 group" do
      tournament = generate_tournament(number_of_participants: 4)
      mocked_lps = mocked_ladder_positions(number_of_ladder_positions: 4)
      group_assignment_strategy = double('group_assignment_strategy', assign: mocked_lps)
      group_assignment_class = double('group_assignment_class', new: group_assignment_strategy)
      
      league_generator = GenerateLeague.new(tournament: tournament, number_of_groups: 1, group_assignment_strategy: group_assignment_class)
      league = league_generator.generate

      expect(league.tournament).to eq(tournament)
      expect(league.groups.count).to eq(1)
      expect(group_assignment_class).to have_received(:new).with(group_id_list: [1], participant_id_list: [1,2,3,4]).ordered
      expect(group_assignment_strategy).to have_received(:assign)
      mocked_lps.each do |lp|
        expect(lp).to have_received(:save)
      end
    end

    it "creates a league with 3 group" do
      tournament = generate_tournament(number_of_participants: 6, seeding: :reverse)
      mocked_lps = mocked_ladder_positions(number_of_ladder_positions: 6)
      group_assignment_strategy = double('group_assignment_strategy', assign: mocked_lps)
      group_assignment_class = double('group_assignment_class', new: group_assignment_strategy)

      league_generator = GenerateLeague.new(tournament: tournament, number_of_groups: 3, group_assignment_strategy: group_assignment_class)
      league = league_generator.generate

      expect(league.groups.count).to eq(3)
      expect(group_assignment_class).to have_received(:new).with(group_id_list: [1,2,3], participant_id_list: [6,5,4,3,2,1]).ordered
      expect(group_assignment_strategy).to have_received(:assign)
      mocked_lps.each do |lp|
        expect(lp).to have_received(:save)
      end
    end
      
    it "if a league already exists it must just re-create new groups for it" do
      tournament = generate_tournament(number_of_participants: 1)
      mocked_lps = mocked_ladder_positions(number_of_ladder_positions: 6)
      group_assignment_strategy = double('group_assignment_strategy', assign: mocked_lps)
      group_assignment_class = double('group_assignment_class', new: group_assignment_strategy)
      exisiting_league = create(:league, tournament: tournament)
      group = create(:group, league: exisiting_league)

      league_generator = GenerateLeague.new(tournament: tournament, number_of_groups: 3, group_assignment_strategy: group_assignment_class)
      league = league_generator.generate

      expect(league).to eq(exisiting_league)
      expect(league.groups.first).to_not eq(group)
    end
  end

  def generate_tournament(number_of_participants:, seeding: :normal)
    tournament = create(:tournament, format: 1)
    (1..number_of_participants).each do |i|
      seed = seeding == :reverse ? number_of_participants-i : i
      participant = create(:participant, name: "Team #{i}")
      create(:tournament_participant, participant: participant, tournament: tournament, seeding: seed)
    end
    return tournament
  end

  def mocked_ladder_positions(number_of_ladder_positions:)
    (1..number_of_ladder_positions).map do |i|
      double('ladder_position', save: true)
    end
  end
end