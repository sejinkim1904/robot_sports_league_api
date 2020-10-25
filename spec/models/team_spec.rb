require 'rails_helper'

describe Team do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('userexample.com').for(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context 'relations' do
    it { should have_many(:rosters) }
    it { should have_many(:bots) }
  end

  context 'instance methods' do
    let!(:team) { create :team }

    it '#generate_bots' do
      expect(team.bots.empty?).to be(true)
      team.generate_bots
      expect(team.bots.size).to eq(100)
      expect(team.bots.first).to be_instance_of(Bot)
    end
  end
end
