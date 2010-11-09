module ClassMatcher
  def contains_class(css_class)
    "contains(concat(' ',normalize-space(@class),' '),' #{css_class} ')"
  end
end

World(ClassMatcher)

Then /^I should see "([^"]*)" in the "([^"]*)" field$/ do |value, field|
  field_labeled(field).value.should == value
end

Then /^I should see nothing in the "([^"]*)" field$/ do |field|
  field_labeled(field).value.should be_nil
end
