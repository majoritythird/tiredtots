Given /^I am signed in$/ do
  Given %(I am signed out)
  @user = @me = Factory(:user)
  Given %(I am on the sign in page)
  When  %(I fill in "Email" with "#{@me.email}")
  And   %(I fill in "Password" with "#{@me.password}")
  And   %(I press "Sign in")
  Then  %(I should see "signed in as #{@me.email}")
end

Given /^I am signed out$/ do
  Given 'I am on the home page'
  begin
    When 'I follow "sign out"'
  rescue
  end
  @user = @me = nil
end

Given /^an existing user$/ do
  @user = @me = Factory(:user)
end

Given /^I have the following (.+):$/ do |child, table|
  Given %(that user has the following child:), table
end
