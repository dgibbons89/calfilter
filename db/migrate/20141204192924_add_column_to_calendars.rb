class AddColumnToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :school_id, :integer
  end
end
