class Welcome < ActiveRecord::Base
	self.table_name = "Sensor"
   
    def set_sensor(sensor_id)
    	@sensor_id = sensor_id
    	self.current_values
    end

	def current_values
		temp = Temperature.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
		hum = Humidity.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
		wind = Wind.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
		rain = Rainfall.where("sensor = ?", @sensor_id).order("Identifier DESC").limit(1).first
		raspberry_temps = self.normalize_records(Temperature.where("sensor = ? and fromDttm > ?", 1, Date.today.to_s).order("Identifier ASC"), 15)
		arduino_temps = self.normalize_records(Temperature.where("sensor = ? and fromDttm > ?", 2, Date.today.to_s).order("Identifier ASC"), 15)
  		{
  			:temperature => temp == nil ? '' : temp.value,
	  		:humidity => hum == nil ? '' : hum.value,
  			:wind_speed => wind == nil ? '' : wind.speed,
  			:rainfall => rain == nil ? '' : rain.value,
	  		:wind_direction => wind == nil ? '' : ['N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'][wind.direction],
	  		:weather_date => temp == nil ? '' : temp.toDttm.strftime("%H:%M %d %b"),
	  		:raspberry_today => raspberry_temps,
	  		:arduino_today => arduino_temps,
	  		:sensor => @sensor_id
	  	}
	end

	def normalize_records(records, interval_minutes)
		minutes_now = Time.now.hour*60 + Time.now.min
		rValue = Array.new
		temp = Array.new(24 * 60 / interval_minutes) { |i| [i*interval_minutes, 0] }
		temp.each { |i| i[1] = self.value_at(records, i[0]) }
		temp.each { |i| if i[1] > -10 && i[0] < minutes_now then rValue << i end }
		rValue.each { |i| i[0] = Time.at(i[0] * 60) }
	end

	def value_at(records, time)
		rValue = -100
		records.each { |i|
			from = i.fromDttm
			to = i.toDttm
			begin
				i.toDttm = 0
				i.fromDttm = from.to_time.hour*60+from.to_time.min
				i.toDttm = to.to_time.hour*60+to.to_time.min
			rescue
			end
		}
		records.each { |i| if i.fromDttm < time then rValue = i.value.to_f end }
		rValue
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
