class HomeController < ApplicationController
  def index
    @cities = City.all
  end

  def forecast
    response = OpenMeteo::Client.forecast coords_params['lat'], coords_params['long']
    report = OpenMeteo::Client.report response
    render turbo_stream: turbo_stream.update('report', partial: "shared/report", locals: { report: report })
  end


  private

  def coords_params
    params.require(:coords).permit(:lat, :long)
  end
end
