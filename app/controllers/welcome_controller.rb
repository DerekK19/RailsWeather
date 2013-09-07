class WelcomeController < ApplicationController

  def index
  	sensor_id = params[:sensor] == nil ? "1" : params[:sensor]
  	@welcome = Welcome.new
  	@welcome.set_sensor(sensor_id)
  end

end
