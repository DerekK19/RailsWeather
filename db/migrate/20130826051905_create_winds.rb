class CreateWinds < ActiveRecord::Migration
  def change
    create_table :winds do |t|
      t.references :sensor
      t.time :fromDttm
      t.time :toDttm
      t.int :direction
      t.float :speed

      t.timestamps
    end
    add_index :winds, :sensor_id
  end
end
