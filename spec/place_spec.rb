require_relative "spec_helper"
require_relative "../lib/place"
require_relative "../lib/map"

describe Place do

  it "should have a address" do
    subject.should respond_to(:address)
  end

  it "should have a coordinates" do
    subject.coordinates = [29,-95]
    subject.coordinates.should eq([29,-95])
  end

  it "should have a pretty name" do
    subject.should respond_to(:name)
  end


  describe ":build" do
    let(:address) { "El Paso, TX"}
    let(:result) { double("el paso", coordinates: [29, -95])}
    let(:name) {"El Paso"}

    it "should return the pretty name if included" do
      expect(Place.build(address, name: name).name).to eq("El Paso")
    end

    it "should return the address as name if pretty name isn't included" do
      expect(Place.build(address).name).to eq("El Paso, TX") 
    end

    it "should build from the map" do
      Map.should_receive(:search).with(address).and_return(result)
      Place.build(address)
    end

    it "should be place" do	
      Map.stub(:search).with(address).and_return(result)
      Place.build(address).should be_a(Place)	
    end
  end

  describe "#to_s" do
    it "should use the name as the to_s" do
      subject.stub(:name) { "Boston" }
      subject.to_s.should eq("Boston")
    end
  end

  describe "#to_coordinates" do
    it "should delegate to_coorinates to coordinates" do
      subject.stub(:coordinates) { [5,5]}
      subject.to_coordinates.should eq ([5,5])
    end
  end
end
