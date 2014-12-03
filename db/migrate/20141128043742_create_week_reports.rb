class CreateWeekReports < ActiveRecord::Migration
  def change
    create_table :week_reports do |t|
      t.integer :user_id
      t.integer :project_id
      t.text :done
      t.text :understood
      t.text :next
      t.text :start_day

      t.timestamps
    end
  end
end
