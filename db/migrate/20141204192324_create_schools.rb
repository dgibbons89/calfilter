class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :school
      t.integer :zipcode
      t.integer :calendar_id

      t.timestamps
    end
  end
end
