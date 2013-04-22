class CreateAttendships < ActiveRecord::Migration
  def change
    create_table :attendships do |t|
      t.boolean :is_attend
      t.integer :event_id

      t.timestamps
    end
    add_index :attendships, [:event_id]
  end
end
