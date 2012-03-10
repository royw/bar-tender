Given /^an authentication service: (.*)$/ do |arg1|
  @service = arg1.to_sym
end

Given /^the service's required parameters: (.*)$/ do |arg1|
  @params = eval(arg1)
end

Given /^the service's accept type is application\/json$/ do
  header 'Accept', 'application/json'
end

When /^the post callback is issued$/ do
  post "/auth/#{@service.to_s}/callback", @params
end

Then /^the response should not be blank$/ do
  last_response.should_not be_blank
end

Then /^the response body should not be blank$/ do
  last_response.body.should_not be_blank
end

Then /^the response body should be parseable by JSON$/ do
  @json_data = JSON.parse last_response.body
end

Then /^the returned JSON should not be blank$/ do
  @json_data.should_not be_blank
end

Then /^the returned JSON should have these values: (.*)$/ do |arg1|
  expected = JSON.parse(arg1)
  expected.each do |k,v|
    @json_data[k].should == v
  end
end
