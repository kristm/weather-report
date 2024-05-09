module OpenMeteo
  class Client
    def self.forecast(lat, long)
      # fetch Forecast record if exist
      # city = City.find_by_lat_and_long lat, long
      # f = Forecast.where(city: city).last
      # data = f.seven_day_forecast if f.created_at > 1.day.ago
      response = OpenMeteo::Request.forecast(lat, long)
      data = JSON.parse response.body
      data["daily"]
    end

    def self.report(data)
      weather_codes = data["weather_code"].map { |code| I18n.t "weather_codes.#{code}" }
    end

    def self.persist(lat, long, data)
      city = City.find_by_lat_and_long lat, long
      f = Forecast.new 
      f.city_id = city.id
      f.serialize_forecast(data)
      f.save
    end
  end
end
