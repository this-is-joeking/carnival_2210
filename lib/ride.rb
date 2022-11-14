class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log

  def initialize(ride_data)
    @name = ride_data[:name]
    @min_height = ride_data[:min_height]
    @admission_fee = ride_data[:admission_fee]
    @excitement = ride_data[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def able_to_ride?(visitor)
    visitor.excited_enough?(@excitement) && 
    visitor.rich_enough?(@admission_fee) && 
    visitor.tall_enough?(@min_height)
  end

  def board_rider(visitor)
    return nil unless able_to_ride?(visitor)
    
    @rider_log[visitor] += 1
    visitor.spending_money -= @admission_fee
    @total_revenue += @admission_fee
  end

  def number_of_riders
    @rider_log.values.sum
  end
end
