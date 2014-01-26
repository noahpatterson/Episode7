require_relative "spec_helper"
require_relative "../lib/sales_person"
require_relative "../lib/calculates_route"
require_relative "../lib/place"

describe SalesPerson do

  let(:city1) {Place.build("3505 Connecticut Ave, DC", name: "Petco")}
  let(:city2) {Place.build("3900 16th st nw, DC", name: "Home")}
  let(:city) {double}
  let(:scheduled) { subject.schedule_city(city) }


  it "should have many cities" do
    scheduled
    subject.cities.should include(city)
  end

  it "should keep the cities only scheduled once" do	
    expect{
      scheduled
      scheduled
    }.to change(subject.cities,:count).by(1) 			
  end

  describe "#route" do
    it "should calculate a route via the CalculatesRoute" do
      cities = [Place, double, double]
      subject.stub(:cities) { cities } 
      CalculatesRoute.should_receive(:calculate).with(cities)
      subject.route
    end

    it "should returns the route from CalculatesRoute" do
      route_stub = [double, double]
      CalculatesRoute.stub(:calculate) { route_stub }
      subject.route.should eq(route_stub)
    end

    it "should be able to add a starting city by name" do
      subject.schedule_city(city1)
      subject.schedule_city(city2)
      starting_point = "home"
      first_route_point = subject.route(starting_point)[0]
      expect(first_route_point.fetch(:point)).to eq(city2)
    end

    it "should use first city if a starting city wasn't specified" do
      subject.schedule_city(city1)
      subject.schedule_city(city2)
      first_route_point = subject.route[0]
      expect(first_route_point.fetch(:point)).to eq(city1)
    end
  end

  describe "#calculate_total_miles" do
    it "should report the total miles traveled on the route" do
      route = [{point: city1, distance: 0}, {point: city2, distance: 1.1}]
      expect(subject.calculate_total_miles(route)).to eq(1.1)
    end
  end

  describe "#calculate_traveling_time" do
    it "shoudld report the traveling time of the route" do
      total_miles = 200
      expect(subject.calculate_traveling_time(total_miles)).to eq(200/55)
    end
  end
  
end
