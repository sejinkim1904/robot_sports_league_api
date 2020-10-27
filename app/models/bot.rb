class Bot < ApplicationRecord
  has_one :roster, dependent: :destroy
  has_one :team, through: :roster

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

  # Class method to get ids from bots with unique ids
  # def self.unique_name_ids
  #   select('DISTINCT ON(bots.name) bots.*').pluck(:id)
  # end
end
