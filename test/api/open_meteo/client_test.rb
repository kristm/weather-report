require 'test_helper'
require 'mocha'

class OpenMeteo::ClientTest < ActiveSupport::TestCase
  test "returns recent forecast if exist" do
    @forecast = forecasts(:one)
    Forecast.stubs(:where).returns(@forecast)
    Forecast.any_instance.stubs(:last).returns(@forecast)
    Forecast.any_instance.expects(:seven_day_forecast)

    city = cities(:one)
    OpenMeteo::Client.forecast(city.lat, city.long)

  end

  test "makes api call if no recent forecast exist" do
    Forecast.stubs(:where).returns([])
    OpenMeteo::Client.stubs(:persist)
    response = mock('response')
    response.stubs(:body).returns("{}")
    OpenMeteo::Request.expects(:forecast).returns(response)

    city = cities(:two)
    OpenMeteo::Client.forecast(city.lat, city.long)
  end
end
