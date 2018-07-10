Types::TournamentType = GraphQL::ObjectType.define do
  name 'Tournament'

  field :id, !types.ID
  field :name, !types.String
  field :format, !types.Int
end