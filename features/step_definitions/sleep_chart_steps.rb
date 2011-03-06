Then /^I should not see a chart$/ do
  page.should have_no_xpath("//div.chart")
end

Then /^I should see (?:|his|her) sleep journal$/ do
  page.should have_css(".sleep_table")
end
