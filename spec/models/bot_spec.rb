require 'rails_helper'

describe Bot do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:speed) }
    it { should validate_presence_of(:strength) }
    it { should validate_presence_of(:agility) }
    it { should validate_numericality_of(:speed).only_integer }
    it { should validate_numericality_of(:strength).only_integer }
    it { should validate_numericality_of(:agility).only_integer }
    it { should validate_numericality_of(:speed).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:strength).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:agility).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:speed).is_less_than_or_equal_to(50) }
    it { should validate_numericality_of(:strength).is_less_than_or_equal_to(50) }
    it { should validate_numericality_of(:agility).is_less_than_or_equal_to(50) }
  end

  context 'relations' do
    it { should have_one(:roster) }
    it { should have_one(:team) }
  end

  context 'instance method' do
    let!(:super_bot) { build :bot, speed: 50, strength: 50, agility: 50 }
    let!(:basic_bot) { build :bot, speed: 10, strength: 10, agility: 10 }
    let!(:ultra_bot) { create :bot, speed: 50, strength: 50, agility: 50 }
    let!(:average_bot) { create :bot, speed: 10, strength: 10, agility: 10 }

    context '#normalize_stats' do
      it 'reduces total stats if > 100' do
        expect(super_bot).to receive(:normalize_stats)
        super_bot.save
        expect(basic_bot).to_not receive(:normalize_stats)
        basic_bot.save
        expect(ultra_bot.speed).to eq(33)
        expect(ultra_bot.strength).to eq(33)
        expect(ultra_bot.agility).to eq(33)
        expect(average_bot.speed).to eq(10)
        expect(average_bot.strength).to eq(10)
        expect(average_bot.agility).to eq(10)
      end
    end
  end
end
