class AssignParticipantsToGroups
  attr_reader :group_list, :participant_list, :seeded

  def initialize(group_list:, participant_list:, assignment_strategy: false)
    @group_list = group_list
    @participant_list = participant_list
    @seeded = seeded
  end

  def assign
    if seeded == :simple_seed
      seeded_assignment_simple
    elsif seeded == :group_seed
      seeded_assignment_by_group
    else
      random_assignment
    end
  end

  private

  # makes one group easier than another
  def seeded_assignment_simple
    current_group_index = -1
    ladder_positions = participant_list.map do |p| 
      current_group_index = next_group_index(current_group_index) # 0
      LadderPosition.new(participant_id: p, group_id: group_list[current_group_index])
    end
  end

  # divides teams into similar seeded bands and randomly assigns one per band
  def seeded_assignment_by_group
    current_group_index = -1
    ladder_positions = participant_list.map do |p| 
      current_group_index = next_group_index(current_group_index) # 0
      LadderPosition.new(participant_id: p, group_id: group_list[current_group_index])
    end
  end

  def random_assignment
    current_group_index = -1
    ladder_positions = participant_list.map do |p| 
      current_group_index = next_group_index(current_group_index) # 0
      LadderPosition.new(participant_id: p, group_id: group_list[current_group_index])
    end
  end

  def next_group_index(current_index)
    current_index >= (@group_list.length-1) ? 0 : next_group_index = current_index + 1
  end
end