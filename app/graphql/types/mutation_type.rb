Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createTournament, function: Resolvers::CreateTournament.new
end