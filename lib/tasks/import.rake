namespace :import do
  task :permissions => :environment do
       Permission.delete_all
     SubPermission.delete_all
     role = Role.first
    per = Permission.create(:name=>"Super Admin Module",:display_name=>"Super Admin Permissions")

    ["Users Management","Roles Management", "Sites Management",
      "Videos Management", "Images Management",
      "Content_Libraries Management", "Add_Forms Management",
      "Site_Pages Management","Add_Files Management","base_colors Management","themes management",
      "Texts Management","Site_Styles Management","site_users","Site_Ecomm Management","Products Management", "Payments Management","System_Configs Mangement","Miscs Management","Product_Filters Management", "Site_Features Management","Gift_Certificates Management","Site_Vendors Management","Inventory_Options Management", "Coupons Management", "try_it_images"].each do |sub_per|
        sub_per_obj = role.sub_permissions.create(:name=>sub_per,:display_name=>sub_per,:permission_id=>per.id)

    end
  end
end

