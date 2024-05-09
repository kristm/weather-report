class Forecast < ApplicationRecord
  belongs_to :city

  def serialize_forecast(data)
    self.days = serialize(data["time"])
    self.codes = serialize(data["weather_code"])
    self.min_temps = serialize(data["temperature_2m_min"])
    self.max_temps = serialize(data["temperature_2m_max"])
    self.sunrise_times = serialize(data["sunrise"])
    self.sunset_times = serialize(data["sunset"])
  end

  def weather_codes
    codes.split("|")
  end

  def seven_day_forecast
    temps ||= temps_min_max
    sunrises ||= sunrise_sunset
    {
      city: city.name,
      time: dates,
      weather_code: weather_codes,
      temperature_2m_min: temps[:min],
      temperature_2m_max: temps[:max],
      sunrise: sunrises[:sunrises],
      sunset: sunrises[:sunsets]
    }
  end

  def temps_min_max
    min = min_temps.split("|") unless min_temps.nil?
    max = max_temps.split("|") unless max_temps.nil?
    {min: min, max: max}
  end

  def sunrise_sunset
    sunrises = sunrise_times.split("|") unless sunrise_times.nil?
    sunsets = sunset_times.split("|") unless sunset_times.nil?
    {sunrises: sunrises, sunsets: sunsets}
  end

  def dates
    days.split("|") unless days.nil?
  end

  private
  
  def serialize(data)
    data.join("|") unless data.nil?
  end

  def unserialize(data)
    data.split("|") unless data.nil?
  end

end
