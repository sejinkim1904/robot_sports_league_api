class Bot < ApplicationRecord
  has_many :rosters, dependent: :destroy
  has_many :teams, through: :rosters

  validates_presence_of :name, :speed, :strength, :agility
  validates_numericality_of :speed,
                            :strength,
                            :agility,
                            only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 50

  before_save :normalize_stats, if: :stats_too_high?

  def normalize_stats
    self.speed = (speed * 0.66).to_i
    self.strength = (strength * 0.66).to_i
    self.agility = (agility * 0.66).to_i
  end

  def stats_too_high?
    (speed + strength + agility) > 100
  end
end
