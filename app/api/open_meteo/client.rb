module OpenMeteo
  class Client
    def self.forecast(lat, long)
      response = OpenMeteo::Request.forecast(lat, long)
      data = JSON.parse response.body
      data["daily"]
    end

    def self.report(data)
      weather_codes = data["weather_code"].map { |code| I18n.t "weather_codes.#{code}" }
    end

    def self.persist(lat, long, data)
      city = City.find_by_lat_and_long lat, long
      f = Forecasts.new 
      f.city_id = city.id
      f.days = Forecasts.serialize(data["time"])
      f.codes = Forecasts.serialize(data["weather_code"])
      f.min_temps = Forecasts.serialize(data["temperature_2m_min"])
      f.max_temps = Forecasts.serialize(data["temperature_2m_max"])
      f.sunrise_times = Forecasts.serialize(data["sunrise"])
      f.sunset_times = Forecasts.serialize(data["sunset"])
      f.save
    end
  end
end
