class RosterSerializer
  include JSONAPI::Serializer

  attributes :team do |object|
    object.team.name
  end

  attributes :role, :total_stats, :bot
end
