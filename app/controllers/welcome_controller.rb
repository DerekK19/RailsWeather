class WelcomeController < ApplicationController

  def index
  	sensor_id = params[:sensor] == nil ? "1" : params[:sensor]
  	@welcome = Welcome.new
  	cv = @welcome.set_sensor(sensor_id)
    temps = (cv[:arduino_today].map{ |i| i[1]}+cv[:raspberry_today].map{ |i| i[1]}).minmax
  	@chart_data = LazyHighCharts::HighChart.new('graph', style: '') do |f|
      f.options[:chart][:defaultSeriesType] = "line"
      f.options[:chart][:height] = 200
      f.options[:colors] = ['#0000ff', '#ff0000']
      f.options[:yAxis][:max] = temps[1]
      f.options[:yAxis][:min] = temps[0]
      f.options[:plotOptions] = {:line => {:marker => {:enabled => false}}}
  	  f.series(:name=>'Arduino', :data=>cv[:arduino_today])
      f.series(:name=>'Raspberry Pi', :data=>cv[:raspberry_today])
  	end

  end

end
