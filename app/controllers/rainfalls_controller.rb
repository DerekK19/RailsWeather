class RainfallsController < ApplicationController

def show
  @rainfall = Rainfall.find(params[:id])
end

def index
  @rainfalls = Rainfall.display_data(params[:page], params[:sort_by])
end

end
