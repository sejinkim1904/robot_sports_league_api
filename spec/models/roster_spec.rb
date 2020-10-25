require 'rails_helper'

describe Roster do
  context 'relations' do
    it { should belong_to(:team) }
    it { should belong_to(:bot) }
  end

  context 'enum' do
    it 'role' do
      should define_enum_for(:role)
        .with_values([:benchwarmer, :alternate, :starter])
    end
  end

  context 'class methods' do
    let!(:team_1) { create :team }
    let!(:team_2) { create :team }
    let!(:bot_1) { create :bot }
    let!(:bot_2) { create :bot, speed: 30, strength: 30, agility: 30 }
    let!(:bot_3) { create :bot }
    let!(:bot_4) { create :bot }

    it '.calculate_stats' do
      built_roster = build :roster, team: team_1, bot: bot_1

      expect(built_roster).to receive(:calculate_stats)
      built_roster.save

      roster = create :roster, team: team_2, bot: bot_2
      expect(roster.total_stats).to eq(90)
    end

    it '.appoint_roles' do
      roster1 = create :roster, team: team_1, bot: bot_1
      roster2 = create :roster, team: team_1, bot: bot_2
      roster3 = create :roster, team: team_1, bot: bot_3
      roster4 = create :roster, team: team_1, bot: bot_4

      starter_ids = [bot_1.id, bot_2.id]
      alternate_ids = [bot_3.id, bot_4.id]

      Roster.appoint_roles(starter_ids, alternate_ids)

      expect(roster1.reload.role).to eq('starter')
      expect(roster2.reload.role).to eq('starter')
      expect(roster3.reload.role).to eq('alternate')
      expect(roster4.reload.role).to eq('alternate')
    end
  end
end
