require_relative "spec_helper"
require_relative "../lib/sales_person"
require_relative "../lib/calculates_route"
require_relative "../lib/place"

describe SalesPerson do

  let(:city1) {Place.build("3505 Connecticut Ave, DC", name: "Petco")}
  let(:city2) {Place.build("3900 16th st nw, DC", name: "Home")}


  it "should have many cities" do
    city = double
    subject.schedule_city(city)
    subject.cities.should include(city)
  end

  it "should keep the cities only scheduled once" do	
    city = double
    expect{
      subject.schedule_city(city)
      subject.schedule_city(city)
    }.to change(subject.cities,:count).by(1) 			
  end

  describe "#route" do
    

    it "should calculate a route via the CalculatesRoute" do
      cities = [double, double, double]
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
      expect(subject.route(starting_point)[0]).to eq(city2)
    end

    it "should use first city if a starting city wasn't specified" do
      subject.schedule_city(city1)
      subject.schedule_city(city2)
      expect(subject.route[0]).to eq(city1)
    end
    
  end
  
end
