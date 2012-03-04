require 'json'

# This test controller is
class TestController < RESTfulController
  map '/test'

  def assert_integer_param(*args)
    fail "Expected integer parameter" if(!args.empty? && (args[0] !~ /^\d+$/))
  end

  def list_set
    assert_request_method('GET')
    {:action => 'list-set',
     :args => []}
  end

  def replace_set
    assert_request_method('PUT')
    {:action => 'replace-set',
     :args => []}
  end

  def create_set
    assert_request_method('POST')
    {:action => 'create-set',
     :args => []}
  end

  def delete_set
    assert_request_method('DELETE')
    {:action => 'delete-set',
     :args => []}
  end

  def list_item(*args)
    assert_request_method('GET')
    assert_integer_param(*args)
    {:action => 'list-item',
     :args => args}
  end

  def replace_item(*args)
    assert_request_method('PUT')
    assert_integer_param(*args)
    {:action => 'replace-item',
     :args => args}
  end

  def create_item(*args)
    assert_request_method('POST')
    assert_integer_param(*args)
    {:action => 'create-item',
     :args => args}
  end

  def delete_item(*args)
    assert_request_method('DELETE')
    assert_integer_param(*args)
    {:action => 'delete-item',
     :args => args}
  end

end
