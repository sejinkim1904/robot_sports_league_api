class TeamSerializer
  include JSONAPI::Serializer
  attributes :email, :team_name
end
