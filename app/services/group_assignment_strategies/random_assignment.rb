module GroupAssignmentStrategies
  class RandomAssignment
    attr_reader :group_id_list, :participant_id_list

    def initialize(group_id_list:, participant_id_list:)
      @group_id_list = group_id_list
      @participant_id_list = participant_id_list
    end

    def assign
      random_assignment
    end

    private

    def random_assignment
      current_group_index = -1
      ladder_positions = []
            
      while(participant_id_list.length > 0)
        current_group_index = next_group_index(current_group_index)
        pid = participant_id_list.delete participant_id_list.sample
        ladder_positions << LadderPosition.new(participant_id: pid, group_id: group_id_list[current_group_index])
      end
      return ladder_positions
    end
  
    def next_group_index(current_index)
      current_index >= (group_id_list.length-1) ? 0 : next_group_index = current_index + 1
    end
  end
end