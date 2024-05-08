module OpenMeteo
  class Request
    include HTTParty
    base_uri 'https://api.open-meteo.com/v1/forecast?'

    def self.forecast(lat, long)
      HTTParty.get("#{self.base_uri}latitude=#{lat}&longitude=#{long}&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset")
    rescue HTTParty::Error => error
      { code: error.http_code, status: error.message }
    end
  end
end
