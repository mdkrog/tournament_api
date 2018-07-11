require 'rails_helper'

RSpec.describe GroupAssignmentStrategies::RandomAssignment, type: :service do
  describe "sort participants into groups" do
    it "splits participants into groups randomly" do
      participant_ids = [1,2,3,4,5,6,7,8]
      group_ids = [1,2]

      group_assigner = GroupAssignmentStrategies::RandomAssignment.new(group_id_list: group_ids, participant_id_list: participant_ids)
      ladder_positions = group_assigner.assign
      
      number_in_first_group = ladder_positions.count { |lp| lp.group_id == group_ids[0] }
      number_in_second_group = ladder_positions.count { |lp| lp.group_id == group_ids[1] }

      expect(number_in_first_group).to eq(4)
      expect(number_in_second_group).to eq(4)
    end
  end
end