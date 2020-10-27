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

    context '#generate_bots' do
      it 'creates 100 bots' do
        expect(team.bots.empty?).to be(true)
        team.generate_bots
        expect(team.bots.size).to eq(100)
        expect(team.bots.first).to be_instance_of(Bot)
      end
    end

    context '#select_bots_for_roster' do
      it 'returns bots with distinct total_stats' do
        team.generate_bots

        selected_bots = team.select_bots_for_roster

        expect(selected_bots.size).to eq(15)
        expect(selected_bots.first).to be_instance_of(Roster)
        selected_bots.each do |roster_bot|
          expect(roster_bot.benchwarmer?).to be(true)
        end
        expect(selected_bots.pluck(:total_stats).uniq.size).to eq(15)
      end
    end

    context '#generate_roster' do
      it 'returns 10 startes and 5 alternates' do
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
    end

    context '#current_roster' do
      it 'returns current roster for a team' do
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
    end

    context '#delete_roster' do
      it 'removes starter and alternate roles' do
        team.generate_bots
        team.generate_roster
  
        expect(team.current_roster.size).to eq(15)
        team.delete_roster
        expect(team.current_roster.empty?).to be(true)
      end
    end
  end
end
