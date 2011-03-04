Then /^(?:|I )should see the following list:$/ do |table|
  table.raw.each_with_index do |element, i|
    page.should have_xpath("//li[#{i+1}][contains(., '#{element.first}')] | //li[#{i+1}]/a[contains(., '#{element.first}')]")
  end
end

Then /^(?:|I )should see the following nested definition list:$/ do |table|
  table.raw.each_with_index do |element, i|
    page.should have_xpath("//dd//dl[#{i+1}]//dt[contains(text(),'#{element.first}')]")
  end
end

Then /^(?:|I )should see the following table:$/ do |table|
  body = Nokogiri(page.body)
  table.hashes.each_with_index do |hash, row|
    hash.each do |title, value|
      heading = body.xpath("//table//th[starts-with(normalize-space(.), '#{title}')]").first
      unless heading
        heading = body.xpath("//table//th/a[starts-with(normalize-space(.), '#{title}')]").first.try(:parent)
      end
      raise "No such heading: #{title}" unless heading
      column = heading.parent.children.select{|e| e.name == 'th'}.reject(&:blank?).index(heading)
      page.should have_xpath("//tr[#{row+1}]/td[#{column+1}]/descendant-or-self::*[contains(normalize-space(.), '#{value}')]")
    end
  end
end

Then /^I should see a table of (\d+) rows?$/ do |count|
  page.all("//*/table/tbody/tr").size.should == count.to_i
end

Then /^I should see a list of (\d+) rows?$/ do |count|
  page.all("//ul/li").size.should == count.to_i
end

When /^I sort the table by the "([^\"]*)" column$/ do |column_name|
  locate("//thead//th[contains(.,'#{column_name}')]").click
end

When /^I click the "([^\"]*)" row$/ do |row|
  locate(:xpath, "//tr[contains(normalize-space(.),'#{row}')]").click
end

Then /^the "([^"]*)" row should be disabled$/ do |row_data|
  page.should have_xpath("//tr[contains(@class,'disabled')][contains(normalize-space(.),'#{row_data}')]")
end

Then /^I should see the following select options:$/ do |table|
  table.raw.each_with_index do |element, i|
    page.should have_xpath("//option[#{i+1}][contains(., '#{element.first}')]")
  end
end
