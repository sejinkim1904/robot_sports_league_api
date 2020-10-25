class Roster < ApplicationRecord
  belongs_to :team
  belongs_to :bot

  enum role: [:benchwarmer, :alternate, :starter]

  before_save :calculate_stats

  def calculate_stats
    self.total_stats = bot.speed + bot.strength + bot.agility
  end
end
