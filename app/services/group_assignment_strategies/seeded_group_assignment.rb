module GroupAssignmentStrategies
  class SeededGroupAssignment
    attr_reader :group_id_list, :participant_id_list

    def initialize(group_id_list:, participant_id_list:)
      @group_id_list = group_id_list
      @participant_id_list = participant_id_list
    end

    def assign
      bands = separate_participants_into_seeded_bands
      distribute_participants_in_bands_across_groups(bands)      
    end

    private

    def number_of_bands
      @number_of_bands ||= participant_id_list.length / group_id_list.length
    end

    def separate_participants_into_seeded_bands
      bands = []
      (0..number_of_bands-1).each do |i|
        bands << participant_id_list.slice!(0,number_of_bands)
      end
      return bands
    end

    def distribute_participants_in_bands_across_groups(bands)
      ladder_positions = []
      bands.each do |current_band|
        group_id_list.each do |group_id|
          pid = current_band.delete current_band.sample
          ladder_positions << LadderPosition.new(participant_id: pid, group_id: group_id)
        end
      end
      return ladder_positions
    end
  end
end