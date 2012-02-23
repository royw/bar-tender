
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
      unless accept.nil?
        http_accept = accept.env['HTTP_ACCEPT']
        unless http_accept.nil?
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

      return name, wish, engine
    end

  end
end

# This test controller is
class TestController < Controller
  map '/test'
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
      list(*args)
    when 'PUT'
      replace(*args)
    when 'POST'
      create(*args)
    when 'DELETE'
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
    fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for list" unless request.get?
    {:action => 'list',
     :args => args}
  end

  def replace(*args)
    fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for replace" unless request.put?
    {:action => 'replace',
     :args => args}
  end

  def create(*args)
    fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for create" unless request.post?
    {:action => 'create',
     :args => args}
  end

  def delete(*args)
    fail "Unacceptable HTTP Method #{request.env['REQUEST_METHOD']} for delete" unless request.delete?
    {:action => 'delete',
     :args => args}
  end

  def self.action_missing(path)
    Ramaze::Log.warn "action_missing(#{path})"
    dirname = File.dirname(path)
    basename = File.basename(path, '.*')
    extname = File.extname(path)
    return if path == '/not_found'
    return if dirname + basename == '/not_found'
    # No normal action, runs on bare metal
    try_resolve('/not_found' + extname)
    #try_resolve('/not_found')
  end

  def not_found(*args)
    Ramaze::Log.warn "not_found(#{args.inspect})"
    # Normal action
    {:action => 'not_found',
     :args => args}
  end

end
