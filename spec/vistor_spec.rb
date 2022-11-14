require './lib/visitor'

RSpec.describe Visitor do
  it 'exists' do
    visitor = Visitor.new('jonny', 62, '$101')

    expect(visitor).to be_a Visitor
  end

  it 'has height, name, preferences, and spending money' do
    visitor1 = Visitor.new('Bruce', 54, '$10')

    expect(visitor1.name).to eq('Bruce')
    expect(visitor1.height).to eq(54)
    expect(visitor1.spending_money).to eq(10)
    expect(visitor1.preferences).to eq([])
  end

  describe '#format_money' do
    it 'takes a dollar value string and turns it to an integer' do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      expect(visitor1.format_money('$123_000')).to eq(123_000)
      expect(visitor1.format_money(123_000)).to eq(123_000)
      expect(visitor1.format_money('123_000')).to eq(123_000)
    end
  end

  describe '#add_preference' do
    it 'adds preferences to the preferences attribute' do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      expect(visitor1.preferences).to eq([])

      visitor1.add_preference(:gentle)
      visitor1.add_preference(:water)

      expect(visitor1.preferences).to eq([:gentle, :water])
    end
  end

  describe '#tall_enough?()' do
    it 'returns boolean stating if visitor is talling enough for ride per given height' do
      visitor1 = Visitor.new('John', 54, '$10')
      visitor2 = Visitor.new('Paul', 36, '$10')
      visitor3 = Visitor.new('Marie', 64, '$10')

      expect(visitor1.tall_enough?(54)).to be true
      expect(visitor2.tall_enough?(54)).to be false
      expect(visitor3.tall_enough?(54)).to be true
      expect(visitor1.tall_enough?(64)).to be false
    end
  end

  describe '#excited_enough?()' do
    it 'return boolean confirming if visitor has preference for given excitement level' do
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:gentle)

      expect(visitor1.excited_enough?(:thrilling)).to be true
      expect(visitor2.excited_enough?(:thrilling)).to be false
      expect(visitor1.excited_enough?(:gentle)).to be false
      expect(visitor2.excited_enough?(:gentle)).to be true
    end
  end
end
