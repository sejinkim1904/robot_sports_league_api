require 'rails_helper'

describe 'Update roster request' do
  let!(:team) { create :team }

  context 'with valid token' do
    it 'returns updated roster' do
      auth_team(team)
      team.generate_bots
      team.generate_roster

      patch '/api/v1/teams/roster', params: {
        starters: team.bots[0..9].map(&:id),
        alternates: team.bots[10..14].map(&:id)
      }

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

      starters = roster['data'].find_all do |roster_bot|
        roster_bot['attributes']['role'] == 'starter'
      end
      expect(starters.size).to eq(10)

      alternates = roster['data'].find_all do |roster_bot|
        roster_bot['attributes']['role'] == 'alternate'
      end
      expect(alternates.size).to eq(5)

      updated_roster_bot_ids = roster['data'].map do |data|
        data['attributes']['bot']['id']
      end

      expect(updated_roster_bot_ids.sort).to eq(team.bots[0..14].map(&:id))
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      patch '/api/v1/teams/roster'

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end
end
