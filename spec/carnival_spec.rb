require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  it 'exists and has attributes that can be read' do
    carnival = Carnival.new('4 Corners Carnival', '30 days')

    expect(carnival).to be_a Carnival
    expect(carnival.name).to eq('4 Corners Carnival')
    expect(carnival.duration).to eq('30 days')
    expect(carnival.rides).to eq([])
  end
end