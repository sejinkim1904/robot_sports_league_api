require 'rails_helper'

describe 'Update roster request' do
  let!(:team) { create :team }

  context 'with valid token' do
    it 'returns updated roster' do
      auth_team(team)
      team.generate_bots
      team.generate_roster

      patch "/api/v1/teams/roster/#{team.current_roster.first.id}", params: {
        role: 'benchwarmer'
      }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      roster = JSON.parse(response.body)

      expect(roster['data']).to have_key('id')
      expect(roster['data']['type']).to eq('roster')
      expect(roster['data']['attributes']).to have_key('team')
      expect(roster['data']['attributes']['role']).to eq('benchwarmer')
      expect(roster['data']['attributes']).to have_key('total_stats')
      expect(roster['data']['attributes']).to have_key('bot')
    end
  end

  context 'when already 10 starters' do
    it 'returns error message' do
      auth_team(team)
      team.generate_bots
      team.generate_roster
      benchwarmer = team.rosters.benchwarmer.first
      benchwarmer.update(total_stats: 0)

      patch "/api/v1/teams/roster/#{benchwarmer.id}", params: {
        role: 'starter'
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Roster cannot have more than 10 starters.')
    end
  end

  context 'when already 5 alternates' do
    it 'returns error message' do
      auth_team(team)
      team.generate_bots
      team.generate_roster
      benchwarmer = team.rosters.benchwarmer.first

      patch "/api/v1/teams/roster/#{benchwarmer.id}", params: {
        role: 'alternate'
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Roster cannot have more than 5 alternates.')
    end
  end

  context 'when total_stats not unique' do
    it 'returns error message' do
      auth_team(team)
      team.generate_bots
      team.generate_roster
      team.current_roster.update_all(total_stats: 100)
      team.current_roster.first.benchwarmer!
      benchwarmer = team.rosters.benchwarmer.first
      benchwarmer.update(total_stats: 100)

      patch "/api/v1/teams/roster/#{benchwarmer.id}", params: {
        role: 'starter'
      }

      error = JSON.parse(response.body)

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      expect(error['error']).to eq('Total stats must be unique on your roster')
    end
  end

  context 'when bot name not unique' do
    it 'returns error message' do
      auth_team(team)
      team.generate_bots
      team.generate_roster
      team.bots.update_all(name: 'bob')
      team.current_roster.first.benchwarmer!
      benchwarmer = team.rosters.benchwarmer.first
      benchwarmer.update(total_stats: 0)

      patch "/api/v1/teams/roster/#{benchwarmer.id}", params: {
        role: 'starter'
      }

      error = JSON.parse(response.body)

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      expect(error['error']).to eq('Bot name must be unique on roster')
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      patch '/api/v1/teams/roster/'

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end
end
