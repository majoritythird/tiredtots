Then /^I should see "([^"]*)" in the "([^"]*)" field$/ do |value, field|
  field_labeled(field).value.should == value
end
