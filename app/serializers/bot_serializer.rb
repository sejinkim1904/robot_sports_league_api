class BotSerializer
  include JSONAPI::Serializer
  attributes :name, :speed, :strength, :agility
end
