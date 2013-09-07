class HumiditiesController < ApplicationController

def show
  @humidity = Humidity.find(params[:id])
end

def index
  params[:sort_by] = 'Identifier desc'
  @humidities = Humidity.display_data(params[:page], params[:sort_by])
end

end
