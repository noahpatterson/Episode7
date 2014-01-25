Dir["./lib/*.rb"].each {|file| require file }


phil = SalesPerson.new
phil.schedule_city(Place.build("3900 16th st nw, DC", name: "Home"))
phil.schedule_city(Place.build("3505 Connecticut Ave, DC", name: "Petco"))
phil.schedule_city(Place.build("1250 24th st nw, DC", name: "Work"))
phil.schedule_city(Place.build("3100 14th St NW, DC", name: "Target"))
phil.schedule_city(Place.build("1440 P St NW, DC", name: "Whole Foods"))



# puts "This is the route from home: #{phil.route}"
puts phil.route("Work")
