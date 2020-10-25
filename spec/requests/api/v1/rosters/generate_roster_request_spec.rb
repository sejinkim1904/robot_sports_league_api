require 'rails_helper'

describe 'Generate roster request' do
  let!(:team) { create :team }

  context 'with valid token' do
    it 'returns a generated roster with 10 starters and 5 alternates' do
      auth_team(team)
      team.generate_bots

      post '/api/v1/teams/generate_roster'

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

      # Second request to generate different roster
      post '/api/v1/teams/generate_roster'

      new_roster = JSON.parse(response.body)

      old_ids = roster['data'].map { |roster_bots| roster_bots['id'] }
      new_ids = new_roster['data'].map { |roster_bots| roster_bots['id'] }

      expect(old_ids.sort).to_not eq(new_ids.sort)
    end
  end

  context 'without generating bots' do
    it 'returns error message' do
      auth_team(team)

      post '/api/v1/teams/generate_roster'

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please generate bots')
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
