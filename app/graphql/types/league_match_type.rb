Types::LeagueMatchType = GraphQL::ObjectType.define do
  name 'LeagueMatch'

  field :id, !types.ID
  field :group_id, types.Int
  field :round, types.Int
  field :participant1_id, types.Int
  field :participant2_id, types.Int
  field :score, types.String

  field :participant1 do
    type Types::ParticipantType
    resolve -> (obj, args, ctx) { obj.participant1 }
  end

  field :participant2 do
    type Types::ParticipantType
    resolve -> (obj, args, ctx) { obj.participant2 }
  end

  field :winner do
    type Types::ParticipantType
    resolve -> (obj, args, ctx) do 
      obj.winner
    end
  end
end
