require 'ramaze'
require "rspec"

require 'net/http'
require 'json'

# helper routine that will send an HTTP request to the test system requesting json content type and return the result
# object returned via json
def http_json(http_method, params, data=nil)
  url = URI.parse("http://localhost:7000/test/#{params}")

  Net::HTTP.start(url.host, url.port) do |http|
    initheader = {}
    response = case http_method
    when :GET
      http.get(url.path, initheader)
    when :PUT
      http.put(url.path, data, initheader)
    when :POST
      http.post(url.path, data, initheader)
    when :DELETE
      http.delete(url.path, initheader)
    end
    JSON.parse(response.body)
  end
end

describe "Ramaze routes" do

  it "should list set" do
    result = http_json(:GET, 'list.json')
    result['action'].should == 'list'
    result['args'].should be_empty
  end

  it "should replace set" do
    result = http_json(:PUT, 'replace.json', 'replace set data')
    result['action'].should == 'replace'
    result['args'].should be_empty
  end
  it "should create set"  do
    result = http_json(:POST, 'create.json', 'create set data')
    result['action'].should == 'create'
    result['args'].should be_empty
  end
  it "should delete set"  do
    result = http_json(:DELETE, 'delete.json')
    result['action'].should == 'delete'
    result['args'].should be_empty
  end

  it "should list item"  do
    result = http_json(:GET, 'list/1.json')
    result['action'].should == 'list'
    result['args'].should_not be_empty
  end
  it "should replace item"  do
    result = http_json(:PUT, 'replace/2.json', 'replace item data')
    result['action'].should == 'replace'
    result['args'].should_not be_empty
  end
  it "should create item"  do
    result = http_json(:POST, 'create/3.json', 'create item data')
    result['action'].should == 'create'
    result['args'].should_not be_empty
  end
  it "should delete item"  do
    result = http_json(:DELETE, 'delete/4.json')
    result['action'].should == 'delete'
    result['args'].should_not be_empty
  end
end