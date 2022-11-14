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

  describe '#add_ride()' do
    it 'adds a ride to the carnival' do
      carnival = Carnival.new('4 Corners Carnival', '30 days')
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      ride3 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })

      expect(carnival.rides).to eq([])

      carnival.add_ride(ride1)

      expect(carnival.rides).to eq([ride1])

      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      expect(carnival.rides).to eq([ride1, ride2, ride3])
    end
  end
end