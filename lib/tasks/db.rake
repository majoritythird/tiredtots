namespace :db do
  desc "Populate the database with minimal development data"
  task :populate => :environment do
    Factory :user, :email => "user@example.com"
  end

  desc "Populate the database with real data"
  task :load => :environment do
    user = Factory(:user, :email => "wesgibbs@gmail.com")
    child = Factory(:child, :name => "Alex", :user => user)
    child.sleep_blocks.create(:start_time => "Oct 10 8pm", :finish_time => "Oct 11 5:30am")
    child.sleep_blocks.create(:start_time => "Oct 11 1:30pm", :finish_time => "Oct 11 2:45pm")
    child.sleep_blocks.create(:start_time => "Oct 11 8pm", :finish_time => "Oct 12 5:30am")
    child.sleep_blocks.create(:start_time => "Oct 12 1:30pm", :finish_time => "Oct 12 2:45pm")
    child.sleep_blocks.create(:start_time => "Oct 12 8pm", :finish_time => "Oct 13 5:10am")
    child.sleep_blocks.create(:start_time => "Oct 13 2pm", :finish_time => "Oct 13 4:10pm")
    child.sleep_blocks.create(:start_time => "Oct 13 8:30pm", :finish_time => "Oct 14 4:50am")
    child.sleep_blocks.create(:start_time => "Oct 14 2pm", :finish_time => "Oct 14 3:15pm")
    child.sleep_blocks.create(:start_time => "Oct 14 8pm", :finish_time => "Oct 15 5:20am")
    child.sleep_blocks.create(:start_time => "Oct 15 3pm", :finish_time => "Oct 15 3:45pm")
    child.sleep_blocks.create(:start_time => "Oct 15 8pm", :finish_time => "Oct 16 5:45am")
    child.sleep_blocks.create(:start_time => "Oct 16 1:30pm", :finish_time => "Oct 16 3:45pm")
    child.sleep_blocks.create(:start_time => "Oct 16 8:30pm", :finish_time => "Oct 17 5:15am")
    child.sleep_blocks.create(:start_time => "Oct 17 2pm", :finish_time => "Oct 17 2:45pm")
    child.sleep_blocks.create(:start_time => "Oct 17 8pm", :finish_time => "Oct 18 5:15am")
    child.sleep_blocks.create(:start_time => "Oct 18 2pm", :finish_time => "Oct 18 3:15pm")
    child.sleep_blocks.create(:start_time => "Oct 18 8pm", :finish_time => "Oct 19 5:40am")
    child.sleep_blocks.create(:start_time => "Oct 19 12:30pm", :finish_time => "Oct 19 1:15pm")
    child.sleep_blocks.create(:start_time => "Oct 19 8pm", :finish_time => "Oct 20 5:15am")
    child.sleep_blocks.create(:start_time => "Oct 20 12:30pm", :finish_time => "Oct 20 2:15pm")
    child.sleep_blocks.create(:start_time => "Oct 20 8pm", :finish_time => "Oct 21 5:15am")
    child.sleep_blocks.create(:start_time => "Oct 21 2pm", :finish_time => "Oct 21 4:15pm")
    child.sleep_blocks.create(:start_time => "Oct 21 8:30pm", :finish_time => "Oct 22 5:15am")
    child.sleep_blocks.create(:start_time => "Oct 21 8:30pm", :finish_time => "Oct 22 5:15am")
    child.sleep_blocks.create(:start_time => "Oct 22 7:30pm", :finish_time => "Oct 23 5:15am")
    child.sleep_blocks.create(:start_time => "Oct 23 1:15pm", :finish_time => "Oct 23 2:15pm")
  end
end
