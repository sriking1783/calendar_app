class CreateTableEvents < ActiveRecord::Migration
  def change
    create_table :table_events do |t|
      t.string :event_name
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
