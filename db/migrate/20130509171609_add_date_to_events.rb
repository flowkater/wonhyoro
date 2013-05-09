class AddDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fromdate, :date
    add_column :events, :todate, :date
  end
end
