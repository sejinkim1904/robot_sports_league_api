require 'rails_helper'

describe 'Get current roster request' do
  let!(:team) { create :team }

  context 'with valid token' do
    it 'returns my teams roster' do
      auth_team(team)
      team.generate_bots
      team.generate_roster

      get '/api/v1/teams/current_roster'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      roster = JSON.parse(response.body)

      expect(roster['data'].size).to eq(15)
      expect(roster['data'][0]).to have_key('id')
      expect(roster['data'][0]['type']).to eq('roster')
      expect(roster['data'][0]['attributes']).to have_key('team')
      expect(roster['data'][0]['attributes']).to have_key('role')
      expect(roster['data'][0]['attributes']).to have_key('total_stats')
      expect(roster['data'][0]['attributes']).to have_key('bot')
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      get '/api/v1/teams/current_roster'

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end
end
