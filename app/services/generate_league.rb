class GenerateLeague
  attr_reader :tournament, :number_of_groups
  attr_writer :group_assignment_strategy
  
  def initialize(tournament:, number_of_groups:, group_assignment_strategy: nil)
    @tournament = tournament
    @number_of_groups = number_of_groups
    @group_assignment_strategy = group_assignment_strategy
  end
  
  def generate
    league = create_league
    group_id_list = create_groups(league)
    participant_id_list = existing_tournament_participants
    assign_participants_to_groups(group_id_list, participant_id_list)
    generate_fixtures(league)
    return league
  end

  private

  def create_league
    tournament.leagues.destroy_all
    League.create(tournament: @tournament, number_of_groups: @number_of_groups)
  end

  def create_groups(league)
    league.groups.destroy_all
    (1..league.number_of_groups).map do |i|
      group = Group.create(league: league)
      group.id
    end
  end

  def assign_participants_to_groups(group_id_list, participant_id_list)
    ladder_positions = group_assignment_strategy.new(group_id_list: group_id_list, participant_id_list: participant_id_list).assign
    save_ladder_positions(ladder_positions)
  end

  def save_ladder_positions(ladder_positions)
    ladder_positions.each do |lp|
      lp.save
    end
  end

  def existing_tournament_participants
    @tournament.participants.map do |p|
      p.id
    end
  end

  def generate_fixtures(league)
    fixture_generator = GenerateLeagueMatches.new
    groups = league.reload.groups
    groups.each do |g|
      fixture_generator.generate(group: g)
    end
  end

  def group_assignment_strategy
    @group_assignment_strategy ||= GroupAssignmentStrategies::RandomAssignment
  end
end