require 'rails_helper'

describe 'Generate roster request' do
  let!(:team) { create :team }

  context 'with valid token' do
    it 'returns created roster' do
      auth_team(team)
      team.generate_bots

      post '/api/v1/teams/roster', params: {
        starters: team.bots[0..9].map(&:id),
        alternates: team.bots[10..14].map(&:id)
      }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      roster = JSON.parse(response.body)

      expect(roster['data'].size).to eq(15)
      expect(roster['data'][0]).to have_key('id')
      expect(roster['data'][0]['type']).to eq('roster')
      expect(roster['data'][0]['attributes']).to have_key('team')
      expect(roster['data'][0]['attributes']).to have_key('role')
      expect(roster['data'][0]['attributes']).to have_key('total_stats')
      expect(roster['data'][0]['attributes']).to have_key('bot')

      starters = roster['data'].find_all do |roster_bot|
        roster_bot['attributes']['role'] == 'starter'
      end
      expect(starters.size).to eq(10)

      alternates = roster['data'].find_all do |roster_bot|
        roster_bot['attributes']['role'] == 'alternate'
      end
      expect(alternates.size).to eq(5)
    end
  end

  context 'Roster already exists' do
    it 'returns error message' do
      auth_team(team)
      team.generate_bots
      team.generate_roster

      post '/api/v1/teams/roster', params: {
        starters: team.bots[0..9].map(&:id),
        alternates: team.bots[10..14].map(&:id)
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Roster already exists')
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      post '/api/v1/teams/generate_roster'

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end
end
