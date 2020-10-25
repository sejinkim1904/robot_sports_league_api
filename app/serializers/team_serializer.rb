class TeamSerializer
  include JSONAPI::Serializer
  attributes :email, :name
end
