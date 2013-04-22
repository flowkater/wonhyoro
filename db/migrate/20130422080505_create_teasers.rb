class CreateTeasers < ActiveRecord::Migration
  def change
    create_table :teasers do |t|
      t.string :content
      t.integer :event_id

      t.timestamps
    end
  end
end
