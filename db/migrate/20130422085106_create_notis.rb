class CreateNotis < ActiveRecord::Migration
  def change
    create_table :notis do |t|
      t.string :content

      t.timestamps
    end
  end
end
