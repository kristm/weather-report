class HomeController < ApplicationController
  def index
    @cities = City.all
  end

  def forecast
    response = OpenMeteo::Client.forecast coords_params['lat'], coords_params['long']
    render turbo_stream: turbo_stream.update('report', "Weather Codes: #{response['daily']['weather_code']}")
  end


  private

  def coords_params
    params.require(:coords).permit(:lat, :long)
  end
end
