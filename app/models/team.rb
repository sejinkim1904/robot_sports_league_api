class Team < ApplicationRecord
  has_secure_password

  has_many :rosters
  has_many :bots, through: :rosters

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true, uniqueness: true

  def generate_bots
    Faker::Name.unique.clear

    100.times.collect do
      bots.create(
        name: Faker::Name.unique.name,
        speed: rand(1..50),
        strength: rand(1..50),
        agility: rand(1..50)
      )
    end
  end

  def current_roster
    rosters.where(role: [:starter, :alternate]).order(role: :desc)
  end

  def generate_roster
    select_bots.each_with_index do |bot, index|
      index <= 9 ? bot.update(role: :starter) : bot.update(role: :alternate)
    end
  end

  def select_bots
    rosters
      .select('DISTINCT ON(rosters.total_stats) rosters.*')
      .order(total_stats: :desc)
      .sample(15)
  end

  def delete_roster
    current_roster.update_all(role: :benchwarmer)
  end
end
