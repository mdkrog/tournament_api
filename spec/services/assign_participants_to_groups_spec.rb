require 'rails_helper'

RSpec.describe AssignParticipantsToGroups, type: :service do
  describe "sort participants into groups" do
    it "splits 8 participants into 2 even groups" do
      participant_id_list = [1,2,3,4,5,6,7,8]
      group_id_list = [1,2]

      group_assigner = AssignParticipantsToGroups.new(group_id_list: group_id_list, participant_id_list: participant_id_list)
      ladder_positions = group_assigner.assign
      
      number_in_first_group = ladder_positions.count { |lp| lp.group_id == group_ids[0] }
      number_in_second_group = ladder_positions.count { |lp| lp.group_id == group_ids[1] }

      expect(number_in_first_group).to eq(4)
      expect(number_in_second_group).to eq(4)
    end

    it "splits 7 participants into 3 uneven groups" do
      seeded_participant_ids = [1,2,3,4,5,6,7]
      group_ids = [1,2,3]

      group_assigner = AssignParticipantsToGroups.new(group_list: group_ids, participant_list: seeded_participant_ids)
      ladder_positions = group_assigner.assign

      number_in_first_group = ladder_positions.count { |lp| lp.group_id == group_ids[0] }
      number_in_second_group = ladder_positions.count { |lp| lp.group_id == group_ids[1] }
      number_in_third_group = ladder_positions.count { |lp| lp.group_id == group_ids[2] }

      expect(number_in_first_group).to eq(3)
      expect(number_in_second_group).to eq(2)
      expect(number_in_third_group).to eq(2)
    end

    it "groups participants according to their seed" do
      seeded_participant_ids = [1,2,3,4,5,6,7,8]
      group_ids = [1,2]

      group_assigner = AssignParticipantsToGroups.new(group_list: group_ids, participant_list: seeded_participant_ids)
      ladder_positions = group_assigner.assign

      participants_in_first_group = ladder_positions.map do |lp| 
        if lp.group_id == group_ids[0]
          lp.participant_id
        end
      end.compact

      participants_in_second_group = ladder_positions.map do |lp| 
        if lp.group_id == group_ids[1]
          lp.participant_id
        end
      end.compact

      expect(participants_in_first_group).to eq([1,3,5,7])
      expect(participants_in_second_group).to eq([2,4,6,8])
    end
  end
end