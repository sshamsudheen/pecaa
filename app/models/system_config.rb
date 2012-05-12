class SystemConfig < ActiveRecord::Base
  has_attached_file :controller_logo,
                    :whiny => false,
                    :styles => { :medium => "300x300",
                                 :thumb  => "150x150" }
end
