class ChangeTableEvents < ActiveRecord::Migration
  def change
    change_table :table_events do |t|
      t.string :repeat
      t.datetime :until
    end
  end
end
