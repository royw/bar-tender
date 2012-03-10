require 'spec_helper'

#ENV['RACK_ENV'] = 'test'

describe("Test RESTfulController") do
  before :all do
    Ramaze::Current.session = Rack::Test::Session.new(Rack::MockSession.new(app))
    @session = Ramaze::Current.session
  end

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
    @session.header 'Accept', 'application/json'
    resp = @session.put '/test'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'replace-set'
    resp_data['args'].should be_empty
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle set create" do
    @session.header 'Accept', 'application/json'
    resp = @session.post '/test'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'create-set'
    resp_data['args'].should be_empty
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle set delete" do
    @session.header 'Accept', 'application/json'
    resp = @session.delete '/test'
    resp.status.should == 200
    resp.header['Content-Type'].should == 'application/json'
    resp_data = JSON.parse(resp.body)
    resp_data['action'].should == 'delete-set'
    resp_data['args'].should be_empty
    resp_data['error'].should be_nil
    resp_data['error_backtrace'].should be_nil
  end

  it "should handle item list" do
    @session.header 'Accept', 'application/json'
    resp = @session.get '/test/1'
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
    @session.header 'Accept', 'application/json'
    resp = @session.put '/test/2'
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
    @session.header 'Accept', 'application/json'
    resp = @session.post '/test/3'
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
    @session.header 'Accept', 'application/json'
    resp = @session.delete '/test/4'
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