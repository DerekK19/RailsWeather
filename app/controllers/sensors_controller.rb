class SensorsController < ApplicationController

def show
  @sensor = Sensor.find(params[:id])
end

def index
  @sensors = Sensor.display_data(params[:page], params[:sort_by])
end

end
