shared_examples_for "any #verb methods" do
  it "requests the URL using VERB" do
    send(verb, "/")

    check last_request.env["REQUEST_METHOD"].should == verb.upcase
    last_response.should be_ok
  end

  it "uses the provided env" do
    send(verb, "/", {}, { "HTTP_USER_AGENT" => "Rack::Test" })
    last_request.env["HTTP_USER_AGENT"].should == "Rack::Test"
  end

  it "yields the response to a given block" do
    yielded = false

    send(verb, "/") do |response|
      response.should be_ok
      yielded = true
    end

    yielded.should be_true
  end

  it "sets the HTTP_HOST header with port" do
    send(verb, "http://example.org:8080/uri")
    last_request.env["HTTP_HOST"].should == "example.org:8080"
  end

  it "sets the HTTP_HOST header without port" do
    send(verb, "/uri")
    last_request.env["HTTP_HOST"].should == "example.org"
  end

  context "for a XHR" do
    it "sends XMLHttpRequest for the X-Requested-With header" do
      send(verb, "/", {}, { :xhr => true })
      last_request.env["HTTP_X_REQUESTED_WITH"].should == "XMLHttpRequest"
      last_request.should be_xhr
    end
  end
end
