require_relative 'place'

class SalesPerson

  attr_reader :cities

  def initialize
    @cities = []
  end

  def schedule_city(city)
    @cities << city unless @cities.include?(city)
  end

  def route(starting_point_name = nil)
    move_starting_point(starting_point_name) if starting_point_name
    CalculatesRoute.calculate(cities)
  end

  private

  def find_starting_point(starting_point_name)
    @cities.bsearch {|place| place.name.downcase == starting_point_name.downcase }
  end

  def move_starting_point(starting_point_name)
    starting_point = find_starting_point(starting_point_name)
    @cities.unshift(@cities.delete(starting_point))
  end
end
