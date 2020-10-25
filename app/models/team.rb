class Team < ApplicationRecord
  has_secure_password

  has_many :rosters
  has_many :bots, through: :rosters
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true, uniqueness: true

  def generate_bots
    100.times.collect do
      bots.create(
        name: Faker::Name.name,
        speed: rand(1..50),
        strength: rand(1..50),
        agility: rand(1..50)
      )
    end
  end
end
