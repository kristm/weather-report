module ApplicationHelper
  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

  def show_icon(code)
    icon = case code
      when 0..1
        "sunny-day.svg"
      when 2..48
        "cloudy.svg"
      when 49..61
        "lightrain.svg"
      when 65..77
        "rainshowers.svg"
      when 78..81
        "lightrain.svg"
      when 82..99
        "thunderstorms.svg"
      else
        "partlycloudy.svg"
      end

    show_svg(icon)
  end
end
