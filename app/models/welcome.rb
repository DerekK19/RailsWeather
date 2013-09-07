class Welcome < ActiveRecord::Base
	self.table_name = "Sensor"
   
    def set_sensor(sensor_id)
    	@sensor_id = sensor_id
    end

	def current_values
		temp = Temperature.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
		hum = Humidity.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
		wind = Wind.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
		rain = Rainfall.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
  		{
  			:temperature => temp == nil ? '' : temp.value,
	  		:humidity => hum == nil ? '' : hum.value,
  			:wind_speed => wind == nil ? '' : wind.speed,
  			:rainfall => rain == nil ? '' : rain.value,
	  		:wind_direction => wind == nil ? '' : ['N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'][wind.direction],
	  		:weather_date => temp == nil ? '' : temp.toDttm.strftime("%H:%M %d %b"),
	  		:sensor => @sensor_id
	  	}
	end

  	def self.display_data(page, sort)
		self.paginate(:page => page,
				  :per_page => 10,
				  :order => sort.nil? ? self.primary_key : sort)
		#can also include :joins and :conditions
	end
	
	def HexColour
		begin
			self.Colour == 0 ? 'FFFFFF' : (self.Colour.to_s(16).rjust(6,'0')[4,2])+(self.Colour.to_s(16).rjust(6,'0')[2,2])+(self.Colour.to_s(16).rjust(6,'0')[0,2])
		rescue
			'FFFFFF'
		end
	end

end
