class Forecasts < ApplicationRecord
  belongs_to :city

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
end
