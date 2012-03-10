Given /^the http method: "([^"]*)"$/ do |arg1|
  @http_method = arg1
end

Given /^the url: "([^"]*)"$/ do |arg1|
  @url = arg1
end

Given /^an Accept type of: "([^"]*)"$/ do |arg1|
  header 'Accept', arg1
end

When /^the method is invoked$/ do
  @response = send(@http_method, @url)
end

Then /^the http response status is: "([^"]*)"$/ do |arg1|
  @response.status.should == arg1.to_i
end

Then /^the http response Content\-Type is: "([^"]*)"$/ do |arg1|
  @response.header['Content-Type'].should == arg1
end

Then /^the response body sans backtrace is: (.*)$/ do |arg1|
  body = case @response.header['Content-Type']
  when 'application/json'
    JSON.parse(@response.body)
  else
    nil
  end
  body.delete('error_backtrace')
  expected = eval(arg1)
  expected.delete('error_backtrace')
  body.should == expected
end
