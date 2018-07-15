class GenerateLeagueMatches
  
  def generate(group:, times_face_same_participant: 1)
    @current_round = 1
    participants = group.participants.pluck(:id)
    all_matches = []
    reverse = false

    (1..times_face_same_participant).each do |i|
      match_ids = pair_participant_ids_into_matches(participants, reverse)
      all_matches += randomly_group_matches_in_rounds(match_ids, participants.length, group)
      reverse = !reverse
    end
    all_matches
  end

  def pair_participant_ids_into_matches(participants, reverse)
    match_ids = []
    participants_copy = participants.map(&:clone)      
    participants.each do |p|
      participants_copy.each do |q|
        if(q!=p)            
          match = reverse ? [q,p] : [p,q]
          match_ids << match
        end
      end
      participants_copy.reject! { |i| i == p }        
    end
    return match_ids
  end

  def randomly_group_matches_in_rounds(match_array, number_of_participants, group)
    matches = []

    total_matches = match_array.length
    matches_per_round = number_of_participants/2
    conflict_counter = 0
    matches_per_round_reducer = 0

    while(!match_array.empty?) do
      match_count = 0
      round_matches = []
      while(match_count <= matches_per_round - matches_per_round_reducer)
        random_match = match_array.sample
        break if random_match.nil?
        if(!round_matches.flatten.include?(random_match[0]) && !round_matches.flatten.include?(random_match[1]))
          round_matches << random_match
          match_array.delete random_match          
          match_count += 1
          matches << LeagueMatch.create(participant1_id: random_match[0], participant2_id: random_match[1], round: @current_round, group: group)
        else
          conflict_counter += 1
          if conflict_counter % 1000 == 0
            matches_per_round_reducer += 1 
          end
        end
      end
      @current_round += 1
      matches_per_round_reducer = 0
    end
    return matches
  end
end