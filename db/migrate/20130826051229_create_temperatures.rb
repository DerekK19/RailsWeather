class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.references :sensor
      t.time :fromDttm
      t.time :toDttm
      t.float :value

      t.timestamps
    end
    add_index :temperatures, :sensor_id
  end
end
