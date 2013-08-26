class Humidity < ActiveRecord::Base
  self.table_name = "Humidity"
  belongs_to :sensor, :foreign_key => 'sensor'
end
