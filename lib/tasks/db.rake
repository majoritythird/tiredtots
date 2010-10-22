namespace :db do
  desc "Populate the database with development data"
  task :populate => :environment do
    Factory :user, :email => "user@example.com"
  end
end
