class Resolvers::CreateTournament < GraphQL::Function
  argument :name, !types.String
  argument :format, !types.Int

  # return type from the mutation
  type Types::TournamentType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
    Tournament.create!(
      name: args[:name],
      format: args[:format],
    )
  end
end