class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :content
      t.boolean :is_vote

      t.timestamps
    end
  end
end
