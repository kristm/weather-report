module OpenMeteo
  class Client
    def self.forecast(lat, long)
      response = OpenMeteo::Request.forecast(lat, long)
      JSON.parse response.body
    end

    def self.report(forecast_data)
      data = forecast_data["daily"]
      weather_codes = data["weather_code"].map { |code| I18n.t "weather_codes.#{code}" }
    end
  end
end
