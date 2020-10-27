class Team < ApplicationRecord
  has_secure_password

  has_many :rosters
  has_many :bots, through: :rosters

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true, uniqueness: true

  # Initial thought process in making sure each bot had a unique name on the
  # roster since a user won't be able to create a bot with chosen attributes
  # through the client
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
    select_bots_for_roster.each_with_index do |roster_bot, index|
      index <= 9 ? roster_bot.starter! : roster_bot.alternate!
    end
  end

  # I wanted to also run a DISTINCT statement on bots.names but I was
  # unable to do so since it overrides the first DISTINCT statment on
  # total_stats. One way would have been to have a class method in the Bot
  # model that pulled ids from bots with unique names and put them in a where
  # clause for this query but that wouldn't have been the best in terms
  # of performance.

  # I also would've liked to use 'RANDOM()' for the order but you must set order
  # to the attribute you stated DISTINCT on
  def select_bots_for_roster
    rosters
      .includes(:bot)
      .select('DISTINCT ON(rosters.total_stats) rosters.*')
      .order(total_stats: :desc)
      .sample(15)
  end

  def delete_roster
    current_roster.update_all(role: :benchwarmer)
  end
end
