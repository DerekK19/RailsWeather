class WelcomeController < ApplicationController
  def index
  	@temperature = Temperature.last
  	@humidity = Humidity.last
  	@wind = Wind.last
  	@rainfall = Rainfall.last
  	@wind_direction = ['N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'][@wind.direction]
  	@weather_date = @temperature.toDttm.strftime("%H:%M %d %b")
  end
end
