Then /^I should see a sleep block from ([^\"]*) to ([^\"]*) on ([^\"]*)$/ do |start, finish, day|
  current_time = start_time = Time.parse(start)
  finish_time = Time.parse(finish)
  result = false
  while current_time <= finish_time do
    result = page.should have_xpath(%|//div[contains(@class,'day #{day.parameterize}')]/a/div[contains(@class,'asleep')][contains(@class,'#{current_time.to_s(:hmm)}')]|)
    current_time += 10.minutes
  end
  result
end

Then /^I should not see a sleep block from ([^\"]*) to ([^\"]*) on ([^\"]*)$/ do |start, finish, day|
  current_time = start_time = Time.parse(start)
  finish_time = Time.parse(finish)
  result = true
  while current_time <= finish_time do
    result = page.should have_no_xpath(%|//div[contains(@class,'day #{day.parameterize}')]/a/div[contains(@class,'asleep')][contains(@class,'#{current_time.to_s(:hmm)}')]|)
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
