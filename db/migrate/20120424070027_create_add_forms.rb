class CreateAddForms < ActiveRecord::Migration
  def change
    create_table :add_forms do |t|
      t.string :name
      t.integer :created_by
      t.string :subject_line
      t.text :delivery_email_address
      t.string :confirmation_text
      t.boolean :use_captcha
      t.boolean :use_field_label
      t.string :submit_button_text

      t.timestamps
    end
  end
end
