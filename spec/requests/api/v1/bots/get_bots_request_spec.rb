require 'rails_helper'

describe 'Get teams bots request' do
  let!(:new_team) { create :team }

  context 'with valid token' do
    it 'returns the teams bots' do
      auth_team(new_team)
      new_team.generate_bots

      get '/api/v1/teams/bots'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      bots = JSON.parse(response.body)

      expect(bots['data'].size).to eq(100)
      expect(bots['data'][0]['type']).to eq('bot')
      expect(bots['data'][0]).to have_key('id')
      expect(bots['data'][0]['attributes']).to have_key('name')
      expect(bots['data'][0]['attributes']).to have_key('speed')
      expect(bots['data'][0]['attributes']).to have_key('strength')
      expect(bots['data'][0]['attributes']).to have_key('agility')
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      get '/api/v1/teams/bots'

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end
end
