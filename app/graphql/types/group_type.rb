Types::GroupType = GraphQL::ObjectType.define do
  name 'Group'

  field :id, !types.ID
  field :league_id, types.Int

  field :league_matches do
    type types[Types::LeagueMatchType]
    resolve -> (obj, args, ctx) {
      obj.league_matches
    }
  end

  field :participants do
    type types[Types::ParticipantType]
    resolve -> (obj, args, ctx) {
      obj.participants
    }
  end
end
