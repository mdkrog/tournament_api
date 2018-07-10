Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # queries are just represented as fields
  field :allTournaments, !types[Types::TournamentType] do
    # resolve would be called in order to fetch data for that field
    resolve -> (obj, args, ctx) { Tournament.all }
  end
end
