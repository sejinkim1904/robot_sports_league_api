require 'rails_helper'

describe 'Delete roster request' do
  let!(:team) { create :team }

  context 'with valid token' do
    it 'returns message for successful delete' do
      auth_team(team)
      team.generate_bots
      team.generate_roster

      expect(team.current_roster.present?).to be(true)

      delete '/api/v1/teams/roster'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      message = JSON.parse(response.body)

      expect(message['message']).to eq('Roster has been deleted.')

      expect(team.current_roster.empty?).to be(true)
    end
  end

  context 'Without valid token' do
    it 'returns error message' do
      delete '/api/v1/teams/roster'

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Please Login')
    end
  end
end
