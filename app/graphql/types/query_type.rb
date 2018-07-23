Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # queries are just represented as fields
  field :allTournaments, !types[Types::TournamentType] do
    resolve -> (obj, args, ctx) { Tournament.all }
  end

  field :allParticipants, !types[Types::ParticipantType] do
    description "A list of all the participants"

    resolve -> (obj, args, ctx) { Participant.all }
  end

  field :participant do
    type Types::ParticipantType
    description "Return a participant"
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { Participant.find(args[:id]) }
  end
end
