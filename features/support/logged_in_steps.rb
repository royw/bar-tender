Given /^a request where the user is not authenticated$/ do
  @user_authenticated = false
end

Given /^An authenticated request$/ do
  @user_authenticated = true
end

When /^an action is executed$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^logged_in\? must be deasserted$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^logged_in\? must be asserted$/ do
  pending # express the regexp above with the code you wish you had
end

