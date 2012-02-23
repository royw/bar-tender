require 'ramaze'
require "rspec"

require 'net/http'
require 'json'

# helper routine that will send an HTTP request to the test system requesting json content type and return the result
# object returned via json
def http_accept_json(http_method, params, data=nil)
  url = URI.parse("http://localhost:7000/test/#{params}")

  Net::HTTP.start(url.host, url.port) do |http|
    initheader = {'Accept:' => 'application/json'}
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

describe "HTTP Accept Header" do

  it "should list set" do
    result = http_accept_json(:GET, 'list')
    result['action'].should == 'list'
    result['args'].should be_empty
  end

  it "should replace set" do
    result = http_accept_json(:PUT, 'replace', 'replace set data')
    result['action'].should == 'replace'
    result['args'].should be_empty
  end
  it "should create set"  do
    result = http_accept_json(:POST, 'create', 'create set data')
    result['action'].should == 'create'
    result['args'].should be_empty
  end
  it "should delete set"  do
    result = http_accept_json(:DELETE, 'delete')
    result['action'].should == 'delete'
    result['args'].should be_empty
  end

  it "should list item"  do
    result = http_accept_json(:GET, 'list/1')
    result['action'].should == 'list'
    result['args'].should_not be_empty
  end
  it "should replace item"  do
    result = http_accept_json(:PUT, 'replace/2', 'replace item data')
    result['action'].should == 'replace'
    result['args'].should_not be_empty
  end
  it "should create item"  do
    result = http_accept_json(:POST, 'create/3', 'create item data')
    result['action'].should == 'create'
    result['args'].should_not be_empty
  end
  it "should delete item"  do
    result = http_accept_json(:DELETE, 'delete/4')
    result['action'].should == 'delete'
    result['args'].should_not be_empty
  end

  it "should return json error on bad method PUT for list" do
    result = http_accept_json(:PUT, 'list', 'list set data')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method POST for list" do
    result = http_accept_json(:POST, 'list', 'list set data')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method DELETE for list" do
    result = http_accept_json(:DELETE, 'list')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method GET for replace" do
    result = http_accept_json(:GET, 'replace')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method POST for replace" do
    result = http_accept_json(:POST, 'replace', 'replace set data')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method DELETE for replace" do
    result = http_accept_json(:DELETE, 'replace', 'replace set data')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method GET for create" do
    result = http_accept_json(:GET, 'create')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method PUT for create" do
    result = http_accept_json(:PUT, 'create', 'create set data')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method DELETE for create" do
    result = http_accept_json(:DELETE, 'create')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method GET for delete" do
    result = http_accept_json(:GET, 'delete')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method PUT for delete" do
    result = http_accept_json(:PUT, 'delete', 'delete set data')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end

  it "should return json error on bad method POST for delete" do
    result = http_accept_json(:POST, 'delete', 'delete set data')
    result['error'].should_not be_nil
    result['error'].should_not be_empty
    result['error_backtrace'].should_not be_nil
    result['error_backtrace'].should_not be_empty
  end
end
