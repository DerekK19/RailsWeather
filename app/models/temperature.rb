class Temperature < ActiveRecord::Base
  self.table_name = "Temperature"
  belongs_to :sensor, :foreign_key => 'sensor'
end
