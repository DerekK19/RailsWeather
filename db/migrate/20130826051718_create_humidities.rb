class CreateHumidities < ActiveRecord::Migration
  def change
    create_table :humidities do |t|
      t.references :sensor
      t.time :fromDttm
      t.time :toDttm
      t.float :value

      t.timestamps
    end
    add_index :humidities, :sensor_id
  end
end
