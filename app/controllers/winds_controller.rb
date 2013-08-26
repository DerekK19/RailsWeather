class WindsController < ApplicationController

def show
  @wind = Wind.find(params[:id])
end

def index
  @winds = Wind.all
end

end
