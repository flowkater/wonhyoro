class AddCheckToTeasers < ActiveRecord::Migration
  def change
    add_column :teasers, :push_check, :boolean, default: false
  end
end
