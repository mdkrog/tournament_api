Types::LeagueType = GraphQL::ObjectType.define do
  name 'League'

  field :id, !types.ID
  field :tournament_id, types.Int
  field :number_of_groups, types.Int
  field :league_settings, types.String

  field :groups do
    type types[Types::GroupType]
    resolve -> (obj, args, ctx) {
      obj.groups
    }
  end
end
