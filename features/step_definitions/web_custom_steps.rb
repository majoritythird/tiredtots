Then /^I should see "([^"]*)" in the "([^"]*)" field$/ do |value, field|
  field_labeled(field).value.should == value
end

Then /^I should see nothing in the "([^"]*)" field$/ do |field|
  field_labeled(field).value.should be_nil
end
