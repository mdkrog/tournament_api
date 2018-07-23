Types::ParticipantType = GraphQL::ObjectType.define do
  name 'Participant'

  field :id, !types.ID
  field :name, !types.String
end
