class HomeController < ApplicationController
  def index
    @cities ||= City.all
  end

  def forecast
    @timezone = coords_params[:timezone]
    response = OpenMeteo::Client.forecast coords_params['lat'], coords_params['long']
    report = OpenMeteo::Client.report response
    days = report[:days].map { |day| format_day(day) }
    report_data = { codes: report[:codes], days: days, sunrise: format_time(report[:sunrise]), sunset: format_time(report[:sunset]) }
    render turbo_stream: turbo_stream.update('report', partial: "shared/report", locals: report_data)
  end


  private

  def format_day(date)
    Date.parse(date).strftime("%A, %B %e")
  end

  def format_time(date)
    DateTime.parse(date).in_time_zone(@timezone).strftime("%l:%M %p")
  end

  def coords_params
    params.require(:coords).permit(:lat, :long, :timezone)
  end
end
