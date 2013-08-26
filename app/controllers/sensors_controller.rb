class SensorsController < ApplicationController

def show
  @sensor = Sensor.find(params[:id])
end

def index
  @sensors = Sensor.all
end

end
