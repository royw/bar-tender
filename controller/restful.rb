class RESTfulController < Controller
  helper :flash

  provide(:json, :type => 'application/json') do |action, value|
    # "value" is the response body from our controller's method
    error_hash = {:error => Ramaze::Current.session.flash[:error],
                  :error_backtrace => Ramaze::Current.session.flash[:error_backtrace]}
    (value.merge(error_hash)).to_json
  end

  def index(*args)
    result = case request.env['REQUEST_METHOD']
    when 'GET'
      fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for list" unless request.get?
      list(*args)
    when 'PUT'
      fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for replace" unless request.put?
      replace(*args)
    when 'POST'
      fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for create" unless request.post?
      create(*args)
    when 'DELETE'
      fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for delete" unless request.delete?
      delete(*args)
    end
    result
  end

  def fail(*args)
    flash[:error] = args.join("\n")
    flash[:error_backtrace] = caller(1)
  end

  # the index action is called automatically when no other action is specified
  def list(*args)
    fail 'not implemented'
  end

  def replace(*args)
    fail 'not implemented'
  end

  def create(*args)
    fail 'not implemented'
  end

  def delete(*args)
    fail 'not implemented'
  end

  def self.action_missing(path)
    fail "action for '#{path}' is missing"
    dirname = File.dirname(path)
    basename = File.basename(path, '.*')
    extname = File.extname(path)
    return if path == '/not_found'
    return if dirname + basename == '/not_found'
    # No normal action, runs on bare metal
    try_resolve('/not_found' + extname)
  end

  def not_found(*args)
  end

end
