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
end