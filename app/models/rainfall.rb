class Rainfall < ActiveRecord::Base
  self.table_name = "Rainfall"
  belongs_to :sensor, :foreign_key => 'sensor'
end
