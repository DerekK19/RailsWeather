class CreateRainfalls < ActiveRecord::Migration
  def change
    create_table :rainfalls do |t|
      t.references :sensor
      t.time :fromDttm
      t.time :toDttm
      t.float :value

      t.timestamps
    end
    add_index :rainfalls, :sensor_id
  end
end
