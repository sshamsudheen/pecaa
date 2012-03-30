class CreateSiteStyles < ActiveRecord::Migration
  def change
    create_table :site_styles do |t|
      t.integer   :site_id
      t.text      :background_style
      t.text      :block_style
      t.text      :text_style
      t.integer   :created_by
      t.boolean   :is_active, :default => true

      t.timestamps
    end
  end
end
