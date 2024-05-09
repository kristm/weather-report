require "test_helper"

describe 'Forecast' do
  before do
    @data = {
     "time"=> ["2024-05-09", "2024-05-10", "2024-05-11", "2024-05-12", "2024-05-13", "2024-05-14", "2024-05-15"],
     "weather_code"=>[51, 0, 3, 61, 65, 61, 2],
     "temperature_2m_min"=>[7.5, 12.6, 16.4, 18.5, 15.0, 13.9, 15.6],
     "temperature_2m_max"=>[16.8, 19.9, 23.2, 22.9, 21.8, 18.8, 24.4],
     "sunrise"=>
        ["2024-05-08T19:42", "2024-05-09T19:41", "2024-05-10T19:40", "2024-05-11T19:39", "2024-05-12T19:39", "2024-05-13T19:38", "2024-05-14T19:37"],
     "sunset"=>
        ["2024-05-09T09:34", "2024-05-10T09:35", "2024-05-11T09:36", "2024-05-12T09:37", "2024-05-13T09:38", "2024-05-14T09:38", "2024-05-15T09:39"]
    }

    @serialized_data = {
      time: "2024-05-09|2024-05-10|2024-05-11|2024-05-12|2024-05-13|2024-05-14|2024-05-15",
      weather_code: "51|0|3|61|65|61|2",
      temperature_2m_min: "7.5|12.6|16.4|18.5|15.0|13.9|15.6",
      temperature_2m_max: "16.8|19.9|23.2|22.9|21.8|18.8|24.4",
      sunrise: "2024-05-08T19:42|2024-05-09T19:41|2024-05-10T19:40|2024-05-11T19:39|2024-05-12T19:39|2024-05-13T19:38|2024-05-14T19:37",
      sunset: "2024-05-09T09:34|2024-05-10T09:35|2024-05-11T09:36|2024-05-12T09:37|2024-05-13T09:38|2024-05-14T09:38|2024-05-15T09:39" 
    }
  end

  describe "#serialize_forecast" do
    it "serializes data" do
      city = City.first
      f = Forecast.new city: city
      f.serialize_forecast @data

      assert_match /(\d{4}\-\d{2}\-\d{2}\|)+/, f.days
      assert_match /(\d+\|)+/, f.codes
      assert_match /(\d+\.\d+\|)+/, f.min_temps
      assert_match /(\d+\.\d+\|)+/, f.max_temps
      assert_match /(\d{4}\-\d{2}\-\d{2}T\d+:\d+\|)+/, f.sunrise_times
      assert_match /(\d{4}\-\d{2}\-\d{2}T\d+:\d+\|)+/, f.sunset_times
    end
  end

  describe "#seven_day_forecast" do
    it "converts to same format as api" do
      city = City.first
      f = Forecast.create(city: city,
        days: @serialized_data[:time],
        codes: @serialized_data[:weather_code],
        min_temps: @serialized_data[:temperature_2m_min],
        max_temps: @serialized_data[:temperature_2m_max],
        sunrise_times: @serialized_data[:sunrise],
        sunset_times: @serialized_data[:sunset]
      )
      report = f.seven_day_forecast
      assert_equal report, {"city"=>"Manila"}.merge(@data)
    end
  end
end
