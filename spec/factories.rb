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
  end

  factory :group do
    league
  end

  factory :league_match do
    group
    association :participant1, factory: :participant
    association :participant2, factory: :participant
  end
end