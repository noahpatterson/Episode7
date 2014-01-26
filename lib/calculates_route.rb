class CalculatesRoute

  def self.calculate(points)
    remaining_points = points
    route = []
    route << {point: remaining_points.slice!(0), distance: 0}
    until remaining_points == [] do 
      next_point = shortest_distance(route.last.fetch(:point), remaining_points)
      remaining_points.delete(next_point.fetch(:point))
      route << next_point
    end
    route
  end

  def self.shortest_distance(from, possible)
    distances = possible.map do |point|
      {point: point, distance: Map.distance_between(from, point)}
    end
    sorted = distances.sort{|a,b| a.fetch(:distance) <=> b.fetch(:distance)}
    sorted.first
  end
end

