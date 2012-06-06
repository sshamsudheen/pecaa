# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120523151814) do

  create_table "add_files", :force => true do |t|
    t.integer  "user_id"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.boolean  "is_deleted",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "add_forms", :force => true do |t|
    t.string   "name"
    t.integer  "created_by"
    t.string   "subject_line"
    t.text     "delivery_email_address"
    t.string   "confirmation_text"
    t.boolean  "use_captcha"
    t.boolean  "use_field_label"
    t.string   "submit_button_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "nickname"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "address_type"
    t.string   "country"
    t.string   "type"
    t.integer  "site_id"
    t.integer  "created_by"
  end

  add_index "addresses", ["created_by"], :name => "index_addresses_on_created_by"
  add_index "addresses", ["site_id"], :name => "index_addresses_on_site_id"

  create_table "base_colors", :force => true do |t|
    t.text     "colors"
    t.string   "name"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_addresses", :force => true do |t|
    t.integer  "billing_id"
    t.string   "nickname"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billings", :force => true do |t|
    t.string   "method"
    t.integer  "site_id"
    t.integer  "order_id"
    t.string   "auth_code"
    t.string   "amount"
    t.integer  "site_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_number"
    t.string   "type_of_card"
  end

  create_table "catalogs", :force => true do |t|
    t.integer  "site_id"
    t.boolean  "is_active",                                     :default => true
    t.string   "name"
    t.string   "supplier_name"
    t.decimal  "price_modifier", :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_libraries", :force => true do |t|
    t.string   "name"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "last_used"
    t.integer  "times_used"
    t.string   "added_by"
    t.boolean  "is_deleted",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_libraries_site_pages", :id => false, :force => true do |t|
    t.integer "content_library_id"
    t.integer "site_page_id"
    t.string  "width"
    t.string  "height"
    t.string  "position"
    t.integer "site_id"
    t.integer "id"
    t.string  "content_type"
  end

  create_table "content_libraries_sites", :id => false, :force => true do |t|
    t.integer "content_library_id"
    t.integer "site_id"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "site_id"
    t.string   "code"
    t.string   "free_text"
    t.datetime "expired_at"
    t.integer  "created_by"
    t.string   "coupon_type"
    t.string   "amount"
    t.boolean  "multi_use"
    t.integer  "no_of_users"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
  end

  create_table "credit_card_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_reports", :force => true do |t|
    t.text     "column_headers"
    t.string   "custom_name"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_shipping_methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_shipping_ranges", :force => true do |t|
    t.string   "start_range"
    t.string   "end_range"
    t.string   "shipping_amount"
    t.integer  "shipping_gateway_attribute_value_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_links", :force => true do |t|
    t.string   "name"
    t.string   "link_url"
    t.string   "target"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gift_certificates", :force => true do |t|
    t.integer  "site_id"
    t.string   "certificate_id"
    t.datetime "expired_date"
    t.string   "purchased_by"
    t.integer  "assigned_to"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
  end

  create_table "groups_roles", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "group_id"
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "histories", :force => true do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "order_id"
    t.text     "changes_txt"
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.boolean  "is_deleted",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", :force => true do |t|
    t.integer  "product_id"
    t.string   "size"
    t.string   "material"
    t.string   "sub_sku"
    t.integer  "inventory"
    t.integer  "trigger"
    t.boolean  "track_inventory"
    t.boolean  "allow_negative_inventory"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_options", :force => true do |t|
    t.integer  "site_id"
    t.string   "trigger_email"
    t.string   "inventory_level"
    t.string   "trigger_level"
    t.boolean  "track_status"
    t.boolean  "allow_negative"
    t.boolean  "show_inventory"
    t.string   "low_inventory_text"
    t.string   "low_inventory_trigger"
    t.string   "out_of_stock_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enable_inventory"
  end

  create_table "miscs", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "address"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_page_id"
    t.integer  "site_id"
  end

  create_table "modifier_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.string   "name"
    t.integer  "question_id"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_notes", :force => true do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "order_products", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "number_of_product"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_ranges", :force => true do |t|
    t.string   "start_range"
    t.string   "end_range"
    t.string   "shipping_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shipping_gateway_attribute_value_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "site_id"
    t.string   "order_id"
    t.string   "status"
    t.string   "customer_email"
    t.string   "pay_status"
    t.string   "ship_status"
    t.integer  "site_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grand_total"
  end

  create_table "password_histories", :force => true do |t|
    t.string   "password"
    t.integer  "created_by"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_gateway_attributes", :force => true do |t|
    t.integer  "payment_gateway_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_gateways", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.decimal  "price_modifier", :precision => 10, :scale => 0
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "list_order"
    t.integer  "site_id"
    t.boolean  "is_active",                                     :default => true
  end

  create_table "product_filters", :force => true do |t|
    t.string   "name"
    t.string   "friendly_name"
    t.boolean  "status"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
  end

  create_table "product_images", :force => true do |t|
    t.string   "name"
    t.boolean  "is_primary",   :default => false
    t.datetime "date_added"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "source_id"
    t.boolean  "is_active",    :default => true
    t.integer  "parent_id"
    t.integer  "list_order"
    t.boolean  "is_thumbnail", :default => false
  end

  create_table "product_options", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.decimal  "price_modifier", :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                                     :default => true
    t.integer  "site_id"
    t.integer  "product_id"
  end

  create_table "product_vendors", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_videos", :force => true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.integer  "source_id"
    t.boolean  "is_active",  :default => true
    t.integer  "parent_id"
    t.integer  "list_order"
    t.boolean  "is_primary", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "sku"
    t.string   "vendor"
    t.integer  "sold"
    t.integer  "viewed"
    t.integer  "rating"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "base_price",          :precision => 10, :scale => 0
    t.decimal  "retail_price",        :precision => 10, :scale => 0
    t.decimal  "cost",                :precision => 10, :scale => 0
    t.decimal  "weight",              :precision => 10, :scale => 0
    t.decimal  "shipping_modifier",   :precision => 10, :scale => 0
    t.decimal  "case_price",          :precision => 10, :scale => 0
    t.integer  "product_category_id"
    t.integer  "site_id"
    t.boolean  "is_featured",                                        :default => false
    t.datetime "featured_at"
    t.string   "featured_text"
  end

  create_table "questions", :force => true do |t|
    t.integer  "add_form_id"
    t.string   "type"
    t.string   "name"
    t.string   "field_type"
    t.text     "validation"
    t.boolean  "mandatory"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "related_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "related_product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "description"
    t.integer  "rating"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.integer  "created_by"
  end

  create_table "roles_sub_permissions", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "sub_permission_id"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "shipping_addresses", :force => true do |t|
    t.string   "nickname"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "shipping_detial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_detials", :force => true do |t|
    t.string   "shipping_id"
    t.integer  "shipping_gateway_id"
    t.string   "cost"
    t.string   "tracking_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "shipping_gateway_attribute_values", :force => true do |t|
    t.integer  "shipping_gateway_attribute_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sites_shipping_gateway_id"
    t.integer  "custom_shipping_method_id"
    t.integer  "parent_id"
  end

  create_table "shipping_gateway_attributes", :force => true do |t|
    t.integer  "shipping_gateway_id"
    t.string   "name"
    t.string   "type"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_gateways", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "site_company_infos", :force => true do |t|
    t.integer  "site_id"
    t.string   "company_name"
    t.text     "address_1"
    t.text     "address_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.text     "email"
    t.text     "phone"
    t.integer  "created_by"
    t.integer  "site_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_features", :force => true do |t|
    t.boolean  "product_filtering_status"
    t.integer  "site_id"
    t.boolean  "advertising_status"
    t.boolean  "show_reviews_from_last_login"
    t.boolean  "cart_setup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ssl_setup"
  end

  create_table "site_groups", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_images", :force => true do |t|
    t.integer  "site_id"
    t.integer  "site_page_id"
    t.integer  "user_id"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_link_accounts", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "created_by"
    t.string   "access"
    t.text     "access_level"
    t.boolean  "is_active",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_links", :force => true do |t|
    t.text     "description"
    t.string   "name"
    t.integer  "created_by"
    t.boolean  "is_active"
    t.string   "title"
    t.text     "target"
    t.integer  "site_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_optional_details", :force => true do |t|
    t.text     "key_words"
    t.text     "google_analytics_code"
    t.text     "description"
    t.string   "logo_alt_text"
    t.string   "twitter_id"
    t.string   "google_id"
    t.string   "facebook_id"
    t.string   "linked_in_id"
    t.boolean  "share"
    t.integer  "site_id"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_page_contents", :force => true do |t|
    t.integer  "site_id"
    t.integer  "content_library_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_pages", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "title"
    t.boolean  "is_active",    :default => true
    t.boolean  "is_home_page", :default => false
    t.text     "more_info"
    t.integer  "created_by"
    t.integer  "parent_id"
    t.integer  "list_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "target"
    t.text     "link_url"
    t.string   "category"
    t.string   "page_layout"
    t.string   "custom_title"
    t.string   "description"
    t.string   "keywords"
    t.string   "custom_url"
  end

  create_table "site_payment_gateway_attribute_values", :force => true do |t|
    t.integer  "sites_payment_gateway_id"
    t.integer  "payment_gateway_attribute_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_styles", :force => true do |t|
    t.integer  "site_id"
    t.text     "background_style"
    t.text     "block_style"
    t.text     "text_style"
    t.integer  "created_by"
    t.boolean  "is_active",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "theme_id"
    t.integer  "base_color_id"
  end

  create_table "site_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "site_id"
    t.string   "name"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_vendors", :force => true do |t|
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone_number"
    t.string   "email"
    t.string   "account_number"
    t.boolean  "status"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.text     "description"
    t.string   "name"
    t.integer  "created_by"
    t.boolean  "is_active",      :default => true
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "domain_name"
    t.string   "company_name"
    t.string   "site_nav_type"
    t.boolean  "enable_tax"
    t.integer  "tax_gateway_id"
  end

  add_index "sites", ["created_by"], :name => "index_sites_on_created_by"
  add_index "sites", ["domain_name"], :name => "index_sites_on_domain_name"
  add_index "sites", ["name"], :name => "index_sites_on_name"

  create_table "sites_payment_gateways", :force => true do |t|
    t.integer  "site_id"
    t.integer  "payment_gateway_id"
    t.boolean  "is_enable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_test_mode"
    t.boolean  "authorize_funds_only"
    t.boolean  "is_cvv"
  end

  create_table "sites_payment_gateways_credit_card_types", :force => true do |t|
    t.integer  "sites_payment_gateway_id"
    t.integer  "credit_card_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites_shipping_gateways", :force => true do |t|
    t.integer  "site_id"
    t.integer  "shipping_gateway_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_enable"
    t.boolean  "is_test_mode"
  end

  create_table "sub_permissions", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.integer  "permission_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_product_options", :force => true do |t|
    t.integer  "site_id"
    t.integer  "parent_id"
    t.integer  "list_order"
    t.integer  "product_option_id"
    t.string   "sub_sku"
    t.integer  "product_image_id"
    t.decimal  "price_modifier_value", :precision => 10, :scale => 0
    t.string   "price_modifier"
    t.string   "name"
    t.boolean  "is_active",                                           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_configs", :force => true do |t|
    t.string   "controller_title"
    t.integer  "image_max_size"
    t.string   "image_types"
    t.integer  "video_max_size"
    t.string   "video_types"
    t.integer  "file_max_size"
    t.string   "file_types"
    t.string   "controller_logo_file_name"
    t.string   "controller_logo_content_type"
    t.integer  "controller_logo_file_size"
    t.datetime "controller_logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_gateway_attribute_values", :force => true do |t|
    t.string   "value"
    t.integer  "tax_gateway_attribute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "parent_id"
    t.boolean  "is_enable",                :default => false
  end

  create_table "tax_gateway_attributes", :force => true do |t|
    t.string   "name"
    t.integer  "tax_gateway_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_gateways", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "texts", :force => true do |t|
    t.integer  "user_id"
    t.string   "text_block_name"
    t.text     "description"
    t.boolean  "is_deleted",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.integer  "base_color_id"
    t.string   "theme_type"
    t.text     "css_style"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",         :default => 0.0
    t.text     "secret_code"
    t.text     "filename"
    t.text     "content_type"
    t.boolean  "is_active",     :default => true
  end

  create_table "try_it_images", :force => true do |t|
    t.string   "name"
    t.string   "hotspot_type"
    t.string   "left_eye_position"
    t.string   "right_eye_position"
    t.integer  "user_id"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", :force => true do |t|
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone_number"
    t.string   "company"
    t.string   "title"
    t.string   "login_page"
    t.string   "user_identity"
    t.text     "notes"
    t.boolean  "active"
    t.datetime "last_login"
    t.string   "role_title"
    t.string   "launch_link"
    t.integer  "created_by"
    t.datetime "last_password_change"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "source_content_type"
    t.string   "source_file_name"
    t.integer  "source_file_size"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_deleted",          :default => false
  end

end
