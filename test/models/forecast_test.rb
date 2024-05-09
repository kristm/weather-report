require "test_helper"

class ForecastTest < ActiveSupport::TestCase
  test "serialize_forecast" do
    city = City.first
    data = {"time"=>
            ["2024-05-09", "2024-05-10", "2024-05-11", "2024-05-12", "2024-05-13", "2024-05-14", "2024-05-15"],
           "weather_code"=>[51, 0, 3, 61, 65, 61, 2],
           "temperature_2m_max"=>[16.8, 19.9, 23.2, 22.9, 21.8, 18.8, 24.4],
           "temperature_2m_min"=>[7.5, 12.6, 16.4, 18.5, 15.0, 13.9, 15.6],
           "sunrise"=>
            ["2024-05-08T19:42", "2024-05-09T19:41", "2024-05-10T19:40", "2024-05-11T19:39", "2024-05-12T19:39", "2024-05-13T19:38", "2024-05-14T19:37"],
           "sunset"=>
            ["2024-05-09T09:34", "2024-05-10T09:35", "2024-05-11T09:36", "2024-05-12T09:37", "2024-05-13T09:38", "2024-05-14T09:38", "2024-05-15T09:39"]
    }

    f = Forecast.new city: city
    f.serialize_forecast data
    assert_match /(\d{4}\-\d{2}\-\d{2}\|)+/, f.days
    assert_match /(\d+\|)+/, f.codes
    assert_match /(\d+\.\d+\|)+/, f.min_temps
    assert_match /(\d+\.\d+\|)+/, f.max_temps
    assert_match /(\d{4}\-\d{2}\-\d{2}T\d+:\d+\|)+/, f.sunrise_times
    assert_match /(\d{4}\-\d{2}\-\d{2}T\d+:\d+\|)+/, f.sunset_times
  end
end
