class AddCalendarTable < ActiveRecord::Migration
  def change
     create_table :calendars do |t|
      t.string :name
     end
  end
end
