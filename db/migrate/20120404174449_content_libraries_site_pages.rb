class ContentLibrariesSitePages < ActiveRecord::Migration
  def change
    create_table :content_libraries_site_pagess, :id => false do |t|
      t.integer :content_library_id
      t.integer :site_page_id
    end
  end
end
