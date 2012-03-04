require 'spec_helper'

Ramaze::Current.session = Rack::Test::Session.new(Rack::MockSession.new(app))

describe("Test RESTfulController") do

  it "should handle set list" do
    header 'Accept', 'application/json'
    resp = get '/test'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'list-set'
    resp_data['args'].should be_empty
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle set replace" do
    header 'Accept', 'application/json'
    resp = put '/test'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'replace-set'
    resp_data['args'].should be_empty
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle set create" do
    header 'Accept', 'application/json'
    resp = post '/test'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'create-set'
    resp_data['args'].should be_empty
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle set delete" do
    header 'Accept', 'application/json'
    resp = delete '/test'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'delete-set'
    resp_data['args'].should be_empty
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle item list" do
    header 'Accept', 'application/json'
    resp = get '/test/1'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'list-item'
    resp_data['args'].size.should == 1
    resp_data['args'][0].should == '1'
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle item replace" do
    header 'Accept', 'application/json'
    resp = put '/test/2'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'replace-item'
    resp_data['args'].size.should == 1
    resp_data['args'][0].should == '2'
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle item create" do
    header 'Accept', 'application/json'
    resp = post '/test/3'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'create-item'
    resp_data['args'].size.should == 1
    resp_data['args'][0].should == '3'
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle item delete" do
    header 'Accept', 'application/json'
    resp = delete '/test/4'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'delete-item'
    resp_data['args'].size.should == 1
    resp_data['args'][0].should == '4'
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

end