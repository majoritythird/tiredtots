Then /^I should not see a chart$/ do
  page.should have_no_xpath("//div.chart")
end
