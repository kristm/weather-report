module OpenMeteo
  class Client
    def self.forecast(lat, long)
      response = OpenMeteo::Request.forecast(lat, long)
      JSON.parse response.body
    end
  end
end
