class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :version
      t.string :store_url

      t.timestamps
    end
  end
end
