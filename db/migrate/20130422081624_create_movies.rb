class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :video_url
      t.integer :videoable_id
      t.string :videoable_type

      t.timestamps
    end
    add_index :movies, [:videoable_id, :videoable_type]
  end
end
