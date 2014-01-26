require 'benchmark'

Dir["./lib/*.rb"].each {|file| require file }

@all_cities = ["Abilene", "Alamo", "Alamo Heights", "Alice", "Allen", "Alpine", "Alvarado", "Alvin", "Amarillo", "Andrews", "Angleton", "Argyle", "Arlington", "Austin", "Azle", "Balch Springs", "Bastrop", "Bay City", "Baytown", "Beaumont", "Bellaire", "Belton", "Benbrook", "Big Spring", "Boerne", "Brenham", "Bridgeport", "Brownfield", "Brownsville", "Brownwood", "Bryan", "Bulverde", "Burkburnett", "Burleson", "Burnet", "Canyon", "Carrollton", "Carthage", "Cedar Hill", "Cedar Park", "Cleburne", "Clute", "College Station", "Colleyville", "Columbus", "Conroe", "Converse", "Coppell", "Copperas Cove", "Corinth", "Corpus Christi", "Corsicana", "Crockett", "Crowley", "Dallas", "Deer Park", "Del Rio", "Denison", "Denton", "Desoto", "Devine", "Dickinson", "Donna", "Dumas", "Duncanville", "Eagle Pass", "Edinburg", "El Campo", "El Paso", "Ennis", "Euless", "Farmers Branch", "Flower Mound", "Fort Stockton", "Fort Worth", "Fredericksburg", "Freeport", "Friendswood", "Frisco", "Gainesville", "Galveston", "Garden Ridge", "Garland", "Gatesville", "Georgetown", "Gonzales", "Granbury", "Grand Prairie", "Granite Shoals", "Grapevine", "Greenville", "Haltom City", "Hamilton", "Harker Heights", "Harlingen", "Hearne", "Henderson", "Hewitt", "Highland Park", "Highland Village", "Houston", "Humble", "Hunters Creek Village", "Huntsville", "Hurst", "Irving", "Jacksonville", "Jasper", "Jersey Village", "Katy", "Keller", "Kemah", "Kennedale", "Kerrville", "Killeen", "Kingsville", "Krum", "Kyle", "La Grange", "La Porte", "Lacy Lakeview", "Lago Vista", "Lake Jackson", "Lakeway", "Lamesa", "Lampasas", "Lancaster", "Laredo", "League City", "Leander", "Leon Valley", "Levelland", "Lewisville", "Littlefield", "Live Oak", "Lockhart", "Longview", "Lowry Crossing", "Lubbock", "Lucas", "Lufkin", "Mansfield", "Manvel", "Marble Falls", "Marshall", "McAllen", "McKinney", "Mesquite", "Midland", "Midlothian", "Mission", "Missouri City", "Mount Pleasant", "Muleshoe", "Murphy", "Nacogdoches", "Nassau Bay", "New Braunfels", "Newark", "Newton", "North Richland Hills", "Oak Ridge North", "Odessa", "Orange", "Overton", "Palacios", "Palestine", "Pampa", "Paris", "Pasadena", "Pearland", "Perryton", "Pflugerville", "Plainview", "Plano", "Port Aransas", "Port Arthur", "Port Lavaca", "Portland", "Richardson", "Richland Hills", "Ridge City", "Rio Grande City", "River Oaks", "Rockport", "Rockwall", "Rosenberg", "Round Rock", "Rowlett", "Royse City", "Rusk", "Sachse", "Saginaw", "San Angelo", "San Antonio", "San Benito", "San Marcos", "San Saba", "Santa Fe", "Schertz", "Seabrook", "Sealy", "Seguin", "Selma", "Seymour", "Shenandoah", "Sherman", "Smithville", "Snyder", "Socorro", "Sonora", "Southlake", "Southside Place", "Spring Valley", "Stafford", "Stephenville", "Sugar Land", "Sulphur Springs", "Sweeny", "Tahoka", "Taylor", "Temple", "Terrell", "Texarkana", "Texas City", "The Colony", "The Woodlands", "Tomball", "Tyler", "Universal City", "University Park", "Victoria", "Waco", "Watauga", "Waxahachie", "Weatherford", "Webster", "Weslaco", "West Columbia", "West Lake Hills", "West Orange", "West University Place", "Weston", "Wharton", "White Settlement", "Wichita Falls", "Willow Park", "Windcrest", "Woodway", "Wylie", "Yoakum"]

  phil = SalesPerson.new
def personal_route(phil)
  phil.schedule_city(Place.build("3900 16th st nw, DC", name: "Home"))
  phil.schedule_city(Place.build("3505 Connecticut Ave, DC", name: "Petco"))
  phil.schedule_city(Place.build("1250 24th st nw, DC", name: "Work"))
  phil.schedule_city(Place.build("3100 14th St NW, DC", name: "Target"))
  phil.schedule_city(Place.build("1440 P St NW, DC", name: "Whole Foods"))
  phil.route("Work")
end

# puts "This is the route from home: #{phil.route}"

def load_cities(num_cities, sales_person)
  times = 0
  until times == num_cities do
    @all_cities.shuffle.take(1).each do |city|
      sales_person.schedule_city(Place.build("#{city}, TX"))
    end
  times +=1
  sleep(2)
  end
end

def Benchmark(num_cities)
  phil = SalesPerson.new
  load_cities(num_cities,phil)
  Benchmark.bm do |x|
    x.report do 
      phil.route
    end
  end
end

def pretty_time(seconds)
  mm, ss = seconds.divmod(60)            #=> [4515, 21]
  hh, mm = mm.divmod(60)           #=> [75, 15]
  dd, hh = hh.divmod(24)           #=> [3, 3]
  "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
end

route = personal_route(phil)
puts route
puts "This is my personal route: #{route.map {|leg| leg.fetch(:point).name}}"
miles = phil.calculate_total_miles(route)
puts "Phil traveled #{miles} miles"
time = phil.calculate_traveling_time(miles, 25)*60*60
puts "It took phil #{pretty_time(time)}"
# puts "This is the benchmark for 2 cities:\n#{Benchmark(2)}"
# puts "This is the benchmark for 10 cities:\n#{Benchmark(10)}"
# puts "This is the benchmark for 50 cities:\n#{Benchmark(50)}"
# puts "This is the benchmark for 2 cities:\n#{Benchmark(200)}"


