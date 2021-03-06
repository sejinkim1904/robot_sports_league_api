require 'rails_helper'

describe 'Generate bots request' do
  let!(:new_team) { create :team }

  context 'with a valid token' do
    it 'returns 100 bots with unique attributes' do
      auth_team(new_team)

      post '/api/v1/teams/generate_bots'

      expect(response).to be_successful
      expect(response.status).to eq(201)

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

  context 'Bots already generated' do
    it 'returns error message' do
      new_team.generate_bots
      auth_team(new_team)

      post '/api/v1/teams/generate_bots'

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Bots already generated')
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      post '/api/v1/teams/generate_bots'

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end
end
