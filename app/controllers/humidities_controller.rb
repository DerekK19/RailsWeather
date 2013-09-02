class HumiditiesController < ApplicationController

def show
  @humidity = Humidity.find(params[:id])
end

def index
  @humidities = Humidity.display_data(params[:page], params[:sort_by])
end

end
