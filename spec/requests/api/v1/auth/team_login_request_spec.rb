require 'rails_helper'

describe 'Team login request' do
  let!(:new_team) { create :team }

  context 'with valid email and password' do
    it 'returns token' do
      allow(JWT).to receive(:encode).and_return('exampletoken')

      post '/api/v1/login', params: {
        email: new_team.email,
        password: new_team.password
      }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      token = JSON.parse(response.body)

      expect(token['token']).to eq('exampletoken')
    end
  end

  context 'with invalid email or password' do
    it 'returns error message' do
      post '/api/v1/login'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body)

      expect(error['error']).to eq('Your email or password is incorrect.')
    end
  end
end
