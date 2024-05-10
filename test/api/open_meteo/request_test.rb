require 'test_helper'

describe "OpenMeteo::Request" do
  describe ".forecast" do
    it "can make request to the api" do
      WebMock.allow_net_connect!
      resp = OpenMeteo::Request.forecast(35.45,139.45)
      assert_requested :get, "https://api.open-meteo.com/v1/forecast?latitude=35.45&longitude=139.45&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset"
    end
  
    it "request success" do
      WebMock.allow_net_connect!
      resp = OpenMeteo::Request.forecast(35.45,139.45)
      assert_equal 200, resp.code, "request ok"
    end
  end
end
