Given /^a user with a roll set to: (.*)$/ do |arg1|
  @user_roll = arg1
end

When /^the user is queried$/ do
  @user = User.find_or_create(:name => 'test', :email => 'test@example.com', :roll => @user_roll)
end

Then /^the script\? method should return: (.*)$/ do |arg1|
  @user.script?.should == !!(arg1 =~ /^true/i)
end

Then /^the admin\? method should return: (.*)$/ do |arg1|
  @user.admin?.should == !!(arg1 =~ /^true/i)
end

