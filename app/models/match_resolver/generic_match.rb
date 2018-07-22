module MatchResolver
  class GenericMatch
    attr_reader :match, :winner, :loser, :result

    def initialize(match:)
      @match = match
      @winner, @loser, @result = determine_winner
    end

    def league_points_for(participant_id:, league:)
      points_total = 0
      if is_draw?
        points_total = league.league_settings['draw_points']
      elsif winner.id == participant_id
        points_total = league.league_settings['win_points']
      end
      points_total
    end

    private

    def determine_winner
      if score.nil?
        [nil, nil, 0] # not yet played
      elsif is_draw?
        [nil, nil, 3]
      elsif participant1_won?
        [match.participant1, match.participant2, 1]
      elsif participant2_won?
        [match.participant2, match.participant1, 2]
      end
    end

    def is_draw?
      score['points'][0] == score['points'][1]
    end

    def participant1_won?
      score['points'][0] > score['points'][1]
    end

    def participant2_won?
      score['points'][0] < score['points'][1]
    end

    def score
      match.score
    end
  end
end