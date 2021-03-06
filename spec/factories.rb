FactoryBot.define do  
  factory :tournament do
    name "My Tournament"
    format 1
  end
  
  factory :participant do
    sequence(:name) { |n| "Team #{n}" }
  end

  factory :tournament_participant do
  end

  factory :league do
    number_of_groups 1
    tournament
    league_settings({win_points: 3, lose_points: 0, draw_points: 1})
  end

  factory :group do
    league
  end

  factory :ladder_position do
  end

  factory :league_match do
    group
    association :participant1, factory: :participant
    association :participant2, factory: :participant
  end
end