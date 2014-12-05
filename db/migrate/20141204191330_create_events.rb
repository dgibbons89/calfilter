class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :details
      t.date :time1
      t.date :time2
      t.string :clock1
      t.string :clock2

      t.timestamps
    end
  end
end
