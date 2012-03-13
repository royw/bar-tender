Given /^required authorization is: (.*)/ do |arg1|
  @required_authorization = !!(arg1 =~ /^true/i)
end

Given /^the user logged in state is: (.*)$/ do |arg1|
  @user_logged_in = !!(arg1 =~ /^true/i)
end

Given /^the user authorization for scripts is: (.*)$/ do |arg1|
  @user_scripts = !!(arg1 =~ /^true/i)
end

Given /^the user authorization for admins is: (.*)$/ do |arg1|
  @user_admin = !!(arg1 =~ /^true/i)
end

When /^Authorization is checked$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^Authorization result is: (.*)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


