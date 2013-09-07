class Humidity < ActiveRecord::Base
  self.table_name = "Humidity"
  belongs_to :sensor, :foreign_key => 'sensor'
	
  	def self.display_data(page, sort)
		self.paginate(:page => page,
				  :per_page => 10,
				  :order => sort.nil? ? self.primary_key : sort)
		#can also include :joins and :conditions
	end
	
	def HexColour
		begin
			sensor.Identifier == 1 ? 'FF7777' : '7777FF'
		rescue
			'D0D0D0'
		end
	end

	def DullHexColour
		begin
			sensor.Identifier == 1 ? 'FFBBBB' : 'BBBBFF'
		rescue
			'B0B0B0'
		end
	end

end
