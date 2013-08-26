class HumiditiesController < ApplicationController

def show
  @humidity = Humidity.find(params[:id])
end

def index
  @humidities = Humidity.all
end

end
