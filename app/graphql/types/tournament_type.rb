Types::TournamentType = GraphQL::ObjectType.define do
  name 'Tournament'

  field :id, !types.ID
  field :name, !types.String
  field :format, !types.Int
  field :discipline, !types.Int

  field :leagues do
    type types[Types::LeagueType]
    resolve -> (obj, args, ctx) {
      obj.leagues
    }
  end
end