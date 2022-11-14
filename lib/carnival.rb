class Carnival
  attr_reader :name,
              :duration,
              :rides

  def initialize(name, duration)
    @name = name
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  def most_popular_ride
    most_riders = @rides.max_by { |ride| ride.number_of_riders }
    @rides.find_all do |ride|
      most_riders.number_of_riders == ride.number_of_riders
    end
  end
end
