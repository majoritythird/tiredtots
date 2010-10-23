module SectionLocator

  def within_parent(content, elements = ['*'], &block)
    expr = "//*[(#{elements.join('|')})/descendant-or-self::*[contains(normalize-space(.), '#{content}')]]"
    within(:xpath, expr, &block)
  end

end

World(SectionLocator)

sections = %w(h1 h2 h3 h4 h5 h6 legend caption dt strong)

When /^(.*) in the "([^\"]*)" section$/ do |action, title|
  within_parent(title, sections) do
    When action
  end
end

When /^(.*) in the "([^\"]*)" section:$/ do |action, title, table|
  within_parent(title, sections) do
    When "#{action}:", table
  end
end

When /^(.*) in the "([^\"]*)" row$/ do |action, title|
  within_parent(title, %w(th td li)) do
    When action
  end
end

When /^(.*) in the "([^\"]*)" question/ do |action, title|
  within(:xpath, "//li[contains(.,'#{title}')]") do
    When action
  end
end
