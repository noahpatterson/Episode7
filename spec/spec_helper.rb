require 'rspec'
require 'bundler/setup'
require 'geocoder'


RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end

Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.add_stub(
  "3505 Connecticut Ave, DC", [
    {
      'latitude'     => 38.935838,
      'longitude'    => -77.05994108029152
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  "3900 16th st nw, DC", [
    {
      'latitude'     => 38.939297,
      'longitude'    => -77.037307
    }
  ]
)

#texas
Geocoder::Lookup::Test.add_stub(
  "Dallas, TX", [
    {
      'latitude'     => 32.7801399,
      'longitude'    => -96.80045109999999
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  "Austin, TX", [
    {
      'latitude'     => 30.267153,
      'longitude'    => -97.7430608,
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  "Lubbock, TX", [
    {
      'latitude'     => 33.70845389999999,
      'longitude'    => -101.748554,
    }
  ]
)
Geocoder::Lookup::Test.add_stub(
  "El Paso, TX", [
    {
      'latitude'     => 31.7699559,
      'longitude'    => -106.4968055,
    }
  ]
)

