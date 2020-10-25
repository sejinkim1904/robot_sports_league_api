require 'rails_helper'

describe 'Team auto login request' do
  let!(:new_team) { create :team }

  context 'with Authorization token' do
    it 'returns logged in team' do
      auth_team(new_team)

      get '/api/v1/auto_login', headers: {
        'Authorization': 'Bearer token'
      }

      expect(response).to be_successful
      expect(response.status).to be(200)

      team = JSON.parse(response.body)

      expect(team['data']).to have_key('id')
      expect(team['data']['type']).to eq('team')
      expect(team['data']['attributes']).to have_key('email')
      expect(team['data']['attributes']).to have_key('name')
    end
  end

  context 'without token' do
    it 'returns error' do
      get '/api/v1/auto_login'

      expect(response).to_not be_successful
      expect(response.status).to be(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('No user logged in')
    end
  end
end
