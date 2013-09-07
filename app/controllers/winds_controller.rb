class WindsController < ApplicationController

def show
  @wind = Wind.find(params[:id])
end

def index
  params[:sort_by] = 'Identifier desc'
  @winds = Wind.display_data(params[:page], params[:sort_by])
end

end
