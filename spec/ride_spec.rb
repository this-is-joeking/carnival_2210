require './lib/visitor'
require './lib/ride'

RSpec.describe Ride do
  it 'exists and ahs attributes' do
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

    expect(ride1).to be_a Ride
    expect(ride1.name).to eq('Carousel')
    expect(ride1.min_height).to eq(24)
    expect(ride1.admission_fee).to eq(1)
    expect(ride1.excitement).to eq(:gentle)
    expect(ride1.total_revenue).to eq(0)
  end

  describe '#board_rider()' do
    it 'adds rider to log and reduces spending money of visitor while adding to revenue' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      ride1.board_rider(visitor1)

      expect(ride1.rider_log).to eq({ visitor1 => 1 })
      expect(visitor1.spending_money).to eq(9)
      expect(ride1.total_revenue).to eq(1)

      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      expect(ride1.rider_log).to eq({ visitor1 => 2, visitor2 => 1 })
      expect(visitor1.spending_money).to eq(8)
      expect(visitor2.spending_money).to eq(4)
      expect(ride1.total_revenue).to eq(3)
    end

    it 'does not add rider if they do not have preference for ride, are too short, or do not have money' do
      ride = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor3 = Visitor.new('Penny', 64, '$15')
      visitor4 = Visitor.new('Raine', 64, '$1')
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)
      ride.board_rider(visitor1)
      ride.board_rider(visitor2)
      ride.board_rider(visitor3)
      ride.board_rider(visitor4)

      expect(ride.rider_log).to eq({ visitor3 => 1 })
    end
  end
end