namespace :db do
  desc "Populate the database with real data"
  task :populate => :environment do
    user = Factory(:user, :email => "bob@example.com", :password => 'testing')
    Time.zone = user.time_zone
    child1 = Factory(:child, :name => "Mary-Kate", :user => user)
    child2 = Factory(:child, :name => "Ashley", :user => user)
    [child1, child2].each do |child|
      14.days.ago.to_date.upto(Time.zone.today) do |date|
        day1 = date.strftime("%b %d")
        day2 = (date + 1.day).strftime("%b %d")
        child.sleep_blocks.create(:start_time => "#{day1} #{rand(3)+7}pm", :finish_time => "#{day2} #{rand(3)+6}am")
        child.sleep_blocks.create(:start_time => "#{day2} #{rand(2)+1}pm", :finish_time => "#{day2} #{rand(3)+3}pm")
      end
    end
  end
end
