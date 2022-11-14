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
    @rides.sum { |ride| ride.total_revenue }
  end

  def most_popular_ride
    most_riders = @rides.max_by { |ride| ride.number_of_riders }
    @rides.find_all do |ride|
      most_riders.number_of_riders == ride.number_of_riders
    end
  end

  def most_profitable_ride
    most_money_made = @rides.max_by { |ride| ride.total_revenue }
    @rides.find_all do |ride|
      most_money_made.total_revenue == ride.total_revenue
    end
  end
end
