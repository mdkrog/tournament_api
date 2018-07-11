require 'rails_helper'

RSpec.describe GroupAssignmentStrategies::SeededGroupAssignment, type: :service do
  describe "sort participants into seeded bands and distribute evenly across groups" do
    it "no participants in the same seeded band can be in the same group" do
      participant_ids = [1,2,3,4,5,6,7,8,9]
      group_ids = [1,2,3]
      
      group_assigner = GroupAssignmentStrategies::SeededGroupAssignment.new(group_id_list: group_ids, participant_id_list: participant_ids)
      ladder_positions = group_assigner.assign
      
      # expected seed_bands
      participants_in_top_seed_band = [1,2,3]
      participants_in_middle_seed_band = [4,5,6]
      participants_in_bottom_seed_band = [7,8,9]

      band1_groups = Set[]
      band2_groups = Set[]
      band3_groups = Set[]

      participants_in_top_seed_band.each do |i|
        lp = ladder_positions.select{ |lp| lp.participant_id == i }
        band1_groups.add(lp.first.group_id)
      end

      participants_in_middle_seed_band.each do |i|
        lp = ladder_positions.select{ |lp| lp.participant_id == i }
        band2_groups.add(lp.first.group_id)
      end

      participants_in_bottom_seed_band.each do |i|
        lp = ladder_positions.select{ |lp| lp.participant_id == i }
        band3_groups.add(lp.first.group_id)
      end

      # a participant from each band is represented in each group
      expect(band1_groups.to_a).to contain_exactly(1,2,3)
      expect(band2_groups.to_a).to contain_exactly(1,2,3)
      expect(band3_groups.to_a).to contain_exactly(1,2,3)
    end
  end
end