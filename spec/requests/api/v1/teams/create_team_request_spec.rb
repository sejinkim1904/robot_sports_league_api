require 'rails_helper'

describe 'Create team request' do
  context 'with valid fields' do
    it 'returns the created team with token' do
      post '/api/v1/teams', params: {
        email: 'team@team.com',
        password: '12345',
        password_confirmation: '12345',
        team_name: 'Voltron'
      }

      expect(response).to be_successful
      expect(response.status).to be(201)

      team = JSON.parse(response.body)

      expect(team['data']).to have_key('id')
      expect(team['data']['type']).to eq('team')
      expect(team['data']['attributes']).to have_key('email')
      expect(team['data']['attributes']).to have_key('team_name')
    end
  end

  context 'with invalid field' do
    it 'returns associated errors' do
      post '/api/v1/teams'

      expect(response).to_not be_successful
      expect(response.status).to be(400)

      error = JSON.parse(response.body)
      message = "Password can't be blank, Email can't be" \
                " blank, Email is invalid, and Team name can't be blank"

      expect(error['error']).to eq(message)
    end
  end
end
