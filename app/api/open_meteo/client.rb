module OpenMeteo
  class Client
    def self.forecast(lat, long)
      # fetch Forecast record if exist
      city = City.find_by_lat_and_long lat, long
      if (forecast = Forecast.where(city_id: city.id, created_at: 24.hours.ago...).last)
        #use forecast record if a recent one exist
        forecast.seven_day_forecast
      else
        response = OpenMeteo::Request.forecast(lat, long)
        data = JSON.parse response.body
        #create forecast record
        self.persist(city, data["daily"])
        data["daily"]
      end
    end

    def self.report(data)
      {
        codes: data["weather_code"],
        days: data["time"],
        sunrise: data["sunrise"].first,
        sunset: data["sunset"].first
      }
    end

    def self.persist(city, data)
      f = Forecast.new city: city
      f.serialize_forecast(data)
      f.save
    end
  end
end
