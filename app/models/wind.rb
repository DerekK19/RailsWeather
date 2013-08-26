class Wind < ActiveRecord::Base
  self.table_name = "Wind"
  belongs_to :sensor, :foreign_key => 'sensor'
end
