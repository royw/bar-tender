
class ServiceController < Controller
  map '/auth/developer'

  provide(:json, :type => 'application/json') do |action, value|
    # "value" is the response body from our controller's method
    error_hash = {:error => Ramaze::Current.session.flash[:error],
                  :error_backtrace => Ramaze::Current.session.flash[:error_backtrace]}
    (value.merge(error_hash)).to_json
  end

  def callback
    Ramaze::Log.info "request.env['omniauth.auth'] => #{auth_hash.inspect}"
    session[:user_name] = auth_hash.info.name
    user = User.find_or_create(:name => auth_hash.info.name, :email => auth_hash.info.email)
    Ramaze::Log.info "Authorization developer callback, user => #{user.inspect}"
    auth_hash
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def failure
    Ramaze::Log.warn("Authorization failure")
    redirect '/'
  end
end