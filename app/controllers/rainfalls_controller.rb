class RainfallsController < ApplicationController

def show
  @rainfall = Rainfall.find(params[:id])
end

def index
  @rainfalls = Rainfall.all
end

end
