namespace :themes do
  task :upload => :environment do
    Theme.all.each{ |t| t.create_template_directory}
  end
end