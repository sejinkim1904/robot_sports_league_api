Roster.destroy_all
Team.destroy_all
Bot.destroy_all

team = Team.create!(
  email: 'stack_sports@rsl.com',
  name: 'Stack Sports',
  password: 'password'
)

team.generate_bots
team.generate_roster