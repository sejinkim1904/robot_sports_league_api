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

    context '.calculate_stats' do
      it 'sums bots stats' do
        built_roster = build :roster, team: team_1, bot: bot_1

        expect(built_roster).to receive(:calculate_stats)
        built_roster.save

        roster = create :roster, team: team_2, bot: bot_2
        expect(roster.total_stats).to eq(90)
      end
    end

    context '.bot_names' do
      it 'returns bot names' do
        create :roster, team: team_1, bot: bot_1
        create :roster, team: team_1, bot: bot_2
        create :roster, team: team_1, bot: bot_3
        create :roster, team: team_1, bot: bot_4

        expect(Roster.bot_names).to contain_exactly(
          bot_1.name, bot_2.name, bot_3.name, bot_4.name
        )
      end
    end
  end
end
