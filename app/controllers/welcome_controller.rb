class WelcomeController < ApplicationController

  def index
  	sensor_id = params[:sensor] == nil ? "1" : params[:sensor]
  	@welcome = Welcome.new
  	cv = @welcome.set_sensor(sensor_id)
    temps = (cv[:arduino_today].map{ |i| i[1]}+cv[:raspberry_today].map{ |i| i[1]}).minmax
  	@chart_data = LazyHighCharts::HighChart.new('graph', style: '') do |f|
      f.options[:chart][:defaultSeriesType] = "line"
      f.options[:chart][:renderTo] = "weather_chart"
      f.options[:chart][:height] = 200
      f.options[:chart][:width] = 400
      f.options[:colors] = ['#0000ff', '#ff0000']
      f.options[:tooltip][:xDateFormat] = '%H:%M'
      f.options[:xAxis][:type] = 'category'
      f.options[:xAxis][:min] = 1
      f.options[:xAxis][:max] = 96
      f.options[:xAxis][:minTickInterval] = 8
      f.options[:xAxis][:tickInterval] = 8
      f.options[:xAxis][:categories] = 
       ['','','','','','','','', '2am',
           '','','','','','','', '4am',
           '','','','','','','', '6am',
           '','','','','','','', '8am',
           '','','','','','','', '10am',
           '','','','','','','', '12pm',
           '','','','','','','', '2pm',
           '','','','','','','', '4pm',
           '','','','','','','', '6pm',
           '','','','','','','', '8pm',
           '','','','','','','', '10pm',
           '','','','','','','', '']
      f.options[:yAxis][:lineWidth] = 1
      f.options[:yAxis][:min] = temps[0]
      f.options[:yAxis][:max] = temps[1]
      f.options[:plotOptions] = {:line => {:marker => {:enabled => false}}}
  	  f.series(:name=>'Arduino', :data=>cv[:arduino_today])
      f.series(:name=>'Raspberry Pi', :data=>cv[:raspberry_today])
  	end

  end

end
