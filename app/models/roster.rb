class Roster < ApplicationRecord
  belongs_to :team
  belongs_to :bot

  validates :bot, presence: true, uniqueness: { scope: :team }

  enum role: [:benchwarmer, :alternate, :starter]

  before_create :calculate_stats

  def calculate_stats
    self.total_stats = bot.speed + bot.strength + bot.agility
  end

  def self.appoint_starters(starter_ids)
    where(bot_id: starter_ids).update_all(role: :starter)
  end

  def self.appoint_alternates(alternate_ids)
    where(bot_id: alternate_ids).update_all(role: :alternate)
  end

  def self.appoint_roles(starter_ids, alternate_ids)
    appoint_starters(starter_ids)
    appoint_alternates(alternate_ids)
  end
end
