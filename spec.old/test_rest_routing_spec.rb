require 'ramaze'
require "rspec"

require 'net/http'
require 'json'

# helper routine that will send an HTTP request to the test system requesting json content type and return the result
# object returned via json
def http_rest_json(http_method, options={})
  url = (options[:params].nil? ? URI.parse("http://localhost:7000/test") : URI.parse("http://localhost:7000/test/#{options[:params]}"))

  Net::HTTP.start(url.host, url.port) do |http|
    initheader = {'Accept:' => 'application/json'}
    response = case http_method
    when :GET
      http.get(url.path, initheader)
    when :PUT
      http.put(url.path, options[:data], initheader)
    when :POST
      http.post(url.path, options[:data], initheader)
    when :DELETE
      http.delete(url.path, initheader)
    end
    JSON.parse(response.body)
  end
end

describe "HTTP RESTful Routes" do

  it "should list set" do
    result = http_rest_json(:GET)
    result['action'].should == 'list'
    result['args'].should be_empty
  end

  it "should replace set" do
    result = http_rest_json(:PUT, :data=>'replace set data')
    result['action'].should == 'replace'
    result['args'].should be_empty
  end
  it "should create set"  do
    result = http_rest_json(:POST, :data=>'create set data')
    result['action'].should == 'create'
    result['args'].should be_empty
  end
  it "should delete set"  do
    result = http_rest_json(:DELETE)
    result['action'].should == 'delete'
    result['args'].should be_empty
  end

  it "should list item"  do
    result = http_rest_json(:GET, :params=>'1')
    result['action'].should == 'list'
    result['args'].should_not be_empty
  end
  it "should replace item"  do
    result = http_rest_json(:PUT, :params=>'2', :data=>'replace item data')
    result['action'].should == 'replace'
    result['args'].should_not be_empty
  end
  it "should create item"  do
    result = http_rest_json(:POST, :params=>'3', :data=>'create item data')
    result['action'].should == 'create'
    result['args'].should_not be_empty
  end
  it "should delete item"  do
    result = http_rest_json(:DELETE, :params=>'4')
    result['action'].should == 'delete'
    result['args'].should_not be_empty
  end

end
