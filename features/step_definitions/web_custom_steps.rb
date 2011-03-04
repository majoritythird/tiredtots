module ClassMatcher
  def contains_class(css_class)
    "contains(concat(' ',normalize-space(@class),' '),' #{css_class} ')"
  end
end

World(ClassMatcher)

Then /^I should see "([^"]*)" in the "([^"]*)" field$/ do |value, field|
  find_field(field).value.should == value
end

Then /^I should see nothing in the "([^"]*)" field$/ do |field|
  find_field(field).value.should be_nil
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  find_field(field).native.xpath("./option[contains(@value,'#{value}')][contains(@selected,'selected')]").should_not be_empty
end
