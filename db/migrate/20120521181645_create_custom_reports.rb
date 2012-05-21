class CreateCustomReports < ActiveRecord::Migration
  def change
    create_table :custom_reports do |t|
      t.body :column_headers
      t.string :custom_name
      t.integer :created_by

      t.timestamps
    end
  end
end
