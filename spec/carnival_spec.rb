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

  describe '#total_revenue' do
    it 'returns the total revenue of all rides' do
      carnival = Carnival.new('4 Corners Carnival', '30 days')
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      ride3 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$50')
      visitor3 = Visitor.new('April', 59, '$1000')
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:gentle)

      expect(carnival.total_revenue).to eq(0)

      3.times { ride1.board_rider(visitor2) }
      4.times { ride2.board_rider(visitor1) }
      5.times { ride3.board_rider(visitor2) }

      expect(carnival.total_revenue).to eq(36)

      10.times { ride3.board_rider(visitor3) }

      expect(carnival.total_revenue).to eq(36)
    end
  end

  describe '#most_popular_ride' do
    it 'returns the ride that has had the most riders' do
      carnival = Carnival.new('4 Corners Carnival', '30 days')
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      ride2 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      ride3 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3) 
      visitor1 = Visitor.new('Bruce', 60, '$1000')
      visitor2 = Visitor.new('Tucker', 54, '$1000')
      visitor3 = Visitor.new('April', 59, '$1000')
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor3.add_preference(:gentle)
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      5.times { ride1.board_rider(visitor1) }
      3.times { ride1.board_rider(visitor2) }
      2.times { ride1.board_rider(visitor3) }
      ride2.board_rider(visitor1)
      3.times { ride2.board_rider(visitor2) }
      ride2.board_rider(visitor3)
      2.times { ride3.board_rider(visitor1) }
      5.times { ride3.board_rider(visitor2) }
      ride3.board_rider(visitor3)

      expect(carnival.most_popular_ride).to eq([ride1])

      2.times { ride3.board_rider(visitor3) }

      expect(carnival.most_popular_ride).to eq([ride1, ride3])
    end
  end
end
