require 'rails_helper'

describe 'Update team name request' do
  let!(:new_team) { create :team }
  let!(:old_team) { create :team, team_name: 'Average Joes' }

  context 'With valid token' do
    it 'returns updated team' do
      allow(JWT).to receive(:decode).and_return([{ 'team_id' => new_team.id }])

      patch "/api/v1/teams/#{new_team.id}", params: {
        team_name: 'Drift Kings'
      }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      team = JSON.parse(response.body)

      expect(team['data']['attributes']['team_name']).to eq('Drift Kings')
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      patch "/api/v1/teams/#{new_team.id}", params: {
        team_name: 'Drift Kings'
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end

  context 'Team name already exists' do
    it 'returns error message' do
      allow(JWT).to receive(:decode).and_return([{ 'team_id' => new_team.id }])

      patch "/api/v1/teams/#{new_team.id}", params: {
        team_name: old_team.team_name
      }

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Team name has already been taken')
    end
  end
end
