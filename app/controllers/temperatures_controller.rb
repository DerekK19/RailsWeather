class TemperaturesController < ApplicationController

def show
  @temperature = Temperature.find(params[:id])
end

def index
  @temperatures = Temperature.all
end

end
