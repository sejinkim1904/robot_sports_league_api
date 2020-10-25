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

    it '#select_bots' do
      team.generate_bots

      expect(team.select_bots.size).to eq(15)
      expect(team.select_bots.first).to be_instance_of(Roster)
      team.select_bots.each do |roster_bot|
        expect(roster_bot.role).to eq('benchwarmer')
      end
    end

    it '#generate_roster' do
      team.generate_bots
      roster = team.generate_roster

      expect(roster.size).to eq(15)
      expect(roster.first).to be_instance_of(Roster)

      roster.sort_by(&:role)[0..4].each do |roster_bot|
        expect(roster_bot.role).to eq('alternate')
      end

      roster.sort_by(&:role)[5..14].each do |roster_bot|
        expect(roster_bot.role).to eq('starter')
      end
    end

    it '#current_roster' do
      team.generate_bots
      team.generate_roster
      roster = team.current_roster

      expect(roster.size).to eq(15)
      expect(roster.first).to be_instance_of(Roster)

      roster[0..9].each do |roster_bot|
        expect(roster_bot.role).to eq('starter')
      end

      roster[10..14].each do |roster_bot|
        expect(roster_bot.role).to eq('alternate')
      end
    end

    it '#delete_roster' do
      team.generate_bots
      team.generate_roster

      expect(team.current_roster.size).to eq(15)
      team.delete_roster
      expect(team.current_roster.empty?).to be(true)
    end
  end
end
