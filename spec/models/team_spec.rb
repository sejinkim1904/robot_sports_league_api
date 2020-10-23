require 'rails_helper'

describe Team do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('userexample.com').for(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:team_name) }
    it { should validate_uniqueness_of(:team_name) }
  end
end
