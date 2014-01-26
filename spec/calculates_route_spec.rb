require_relative "spec_helper"
require_relative "../lib/calculates_route"
require_relative "../lib/place"

describe CalculatesRoute do
  let(:dallas  ) { Place.build("Dallas, TX")          }
  let(:austin  ) { Place.build("Austin, TX")          }
  let(:lubbock ) { Place.build("Lubbock, TX")         }
  let(:el_paso ) { Place.build("El Paso, TX")         }
  let(:points  ) { [dallas, el_paso, austin, lubbock] }

  it "should calculate the route" do
    expected = [dallas, austin, lubbock, el_paso]
    route = CalculatesRoute.calculate(points)
    route.map {|leg| leg.fetch(:point)}.should eq(expected)
  end

  it "should also output the distance of each leg" do
    CalculatesRoute.calculate(points)[0].fetch(:distance).should eq(0)
  end

end
