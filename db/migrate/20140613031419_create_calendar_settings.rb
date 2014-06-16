class CreateCalendarSettings < ActiveRecord::Migration
  def change
    create_table :calendar_settings do |t|
      t.string :default_view
      t.integer :popup_time

      t.timestamps
    end
  end
end
