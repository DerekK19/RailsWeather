class TemperaturesController < ApplicationController

def show
  @temperature = Temperature.find(params[:id])
end

def index
  params[:sort_by] = 'Identifier desc'
  @temperatures = Temperature.display_data(params[:page], params[:sort_by])
end

end
