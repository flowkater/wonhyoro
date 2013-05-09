class AddCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :count, :integer, default: 0
  end
end
