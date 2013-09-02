class Temperature < ActiveRecord::Base
  self.table_name = "Temperature"
  belongs_to :sensor, :foreign_key => 'sensor'
  
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
