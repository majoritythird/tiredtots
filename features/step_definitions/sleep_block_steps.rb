Then /^I should see only one block for ([^\"]*) on ([^\"]*)$/ do |time, day|
  time = Time.parse(time)
  page.should have_xpath(%|//div[#{contains_class(day.parameterize)}]/div[#{contains_class(time.to_s(:hmm))}]|, :count => 1)
end

Then /^I should see a sleep block from ([^\"]*) to ([^\"]*) on ([^\"]*)$/ do |start, finish, day|
  current_time = start_time = Time.parse(start)
  finish_time = Time.parse(finish)
  result = false
  while current_time <= finish_time do
    result = page.should have_xpath(%|//div[contains(@class,'day #{day.parameterize}')]/div[contains(@class,'asleep')][contains(@class,'#{current_time.to_s(:hmm)}')]|)
    current_time += 10.minutes
  end
  result
end

Then /^I should not see a sleep block from ([^\"]*) to ([^\"]*) on ([^\"]*)$/ do |start, finish, day|
  current_time = start_time = Time.parse(start)
  finish_time = Time.parse(finish)
  result = true
  while current_time <= finish_time do
    result = page.should have_no_xpath(%|//div[contains(@class,'day #{day.parameterize}')]/div[contains(@class,'asleep')][contains(@class,'#{current_time.to_s(:hmm)}')]|)
    current_time += 10.minutes
  end
  result
end

Then /^I should see no data for ([^\"]*) on ([^\"]*)$/ do |time, day|
  page.should have_xpath(%|//div[contains(@class,'day #{day.parameterize}')]/div[contains(@class,'no_data')][contains(@class,'#{Time.parse(time).to_s(:hmm)}')]|)
end

When /^I follow a bookmark to the sleep graph page for "([^\"]*)"$/ do |child_name|
  visit "/children/alex/sleep_blocks"
end

Then /^I should see "([^"]*)" on ([^"]*)$/ do |total, day|
  page.should have_xpath(%|//div[contains(@class,'day #{day.parameterize}')]/div[contains(@class,'total')][contains(normalize-space(.), '#{total}')]|)
end

Given /^that child has (\d+) sleep blocks starting on "([^"]*)"$/ do |number, begin_date|
  time = Time.parse(begin_date).beginning_of_day
  number.to_i.times do
    start_time = time
    finish_time = time + 1.hour
    @child.sleep_blocks.create(:start_time => start_time, :finish_time => finish_time)
    time += (60*60*24)
  end
end

Then /^I should see one row for "([^"]*)"$/ do |day|
  page.should have_xpath(%|//div[@class = "day #{day.parameterize}"]|, :count => 1)
end

Then /^I should not see a row for "([^"]*)"$/ do |day|
  page.should have_no_xpath(%|//div[@class = "day #{day.parameterize}"]|)
end
