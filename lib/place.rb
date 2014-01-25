require_relative "./map"

class Place
  attr_accessor :address, :coordinates, :name

  def self.build(address, options= {})
    results = Map.search(address)
    Place.new.tap do |p|
      p.address = address
      p.coordinates = results.coordinates
      p.name = options[:name].nil? ? address : options[:name]
    end
  end

  def to_s
    name
  end

  def to_coordinates
    coordinates
  end
end
