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

  def seven_day_forecast
    temps ||= temps_min_max
    {
      "city" => city.name,
      "time" => unserialize(days),
      "weather_code" => unserialize(codes).map(&:to_i),
      "temperature_2m_min" => unserialize(min_temps)&.map(&:to_f),
      "temperature_2m_max" => unserialize(max_temps)&.map(&:to_f),
      "sunrise" => unserialize(sunrise_times),
      "sunset" => unserialize(sunset_times)
    }
  end

  private
  
  def serialize(data)
    data.join("|") unless data.nil?
  end

  def unserialize(data)
    data.split("|") unless data.nil?
  end

end
