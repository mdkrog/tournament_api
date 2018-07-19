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
      ladder_positions = []
      cycle_group_enum = group_id_list.cycle
            
      while(participant_id_list.length > 0)
        group_id = cycle_group_enum.next
        pid = participant_id_list.delete participant_id_list.sample
        ladder_positions << LadderPosition.new(participant_id: pid, group_id: group_id)
      end
      return ladder_positions
    end
  end
end