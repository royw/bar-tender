require 'json'

module Innate
  module Node
    # Resolve possible provides for the given +path+ from {provides}.
    #
    # @param [String] path
    #
    # @return [Array] with name, wish, engine
    #
    # @api internal
    # @see Node::provide Node::provides
    # @author manveru
    def find_provide(path)
      pr = provides
      name, wish, engine = path, 'html', pr['html_handler']

      accept = request.env['rack-accept.request']
      #puts "accept=>#{accept.inspect}"
      unless accept.nil?
        http_accept = accept.env['HTTP_ACCEPT']
        unless http_accept.nil?
          #puts "http_accept=>#{http_accept}"
          types = http_accept.strip.split(/[, ]+/)
          unless types.empty?
            content_types = ancestral_trait.reject{|key, value| key !~ /_content_type$/ }
            matching_types = content_types.select{|key, value| types.include? value}
            matching_types.each do |key, value|
              prefix = $1 if key =~ /^(.*)_content_type$/
              handler = pr["#{prefix}_handler"]
              unless handler.nil?
                name, wish, engine = path, prefix, handler
                break
              end
            end
          end
        end
      end

      pr.find do |key, value|
        key = key[/(.*)_handler$/, 1]
        next unless path =~ /^(.+)\.#{key}$/i
        name, wish, engine = $1, key, value
      end

      #puts "name=>#{name}, wish=>#{wish}, engine=>#{engine}"
      return name, wish, engine
    end

  end
end

class RESTfulController < Controller
  helper :flash

  provide(:json, :type => 'application/json') do |action, value|
    # "value" is the response body from our controller's method
    error_hash = {:error => Ramaze::Current.session.flash[:error],
                  :error_backtrace => Ramaze::Current.session.flash[:error_backtrace]}
    (value.merge(error_hash)).to_json
  end

  RestMethods = {
      'GET' => :list,
      'PUT' => :replace,
      'POST' => :create,
      'DELETE' => :delete
  }

  def index(*args)
    request_method = request.env['REQUEST_METHOD']
    method = RestMethods[request_method]
    if method.nil?
      fail "Invalid request method '#{request_method}'"
      return
    end
    method = (method.to_s + (args.empty? ? '_set' : '_item')).to_sym
    if self.respond_to? method
      self.send(method, *args)
    else
      fail "Controller action method '#{method.to_s}' not implemented"
    end
  end

  def fail(*args)
    flash[:error] = args.join("\n")
    flash[:error_backtrace] = caller(1)
  end

  def assert_request_method(*required_request_methods)
    request_method = request.env['REQUEST_METHOD']
    fail "Unacceptable HTTP Method #{request_method}" unless required_request_methods.include? request_method
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
