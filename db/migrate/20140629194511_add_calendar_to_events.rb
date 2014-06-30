class AddCalendarToEvents < ActiveRecord::Migration
  def change
    add_column :table_events, :calendar_id, :integer
  end
end
