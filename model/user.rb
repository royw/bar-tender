
class User < Sequel::Model(:users)

  def script?
    roll == 'script'
  end

  def admin?
    roll == 'admin'
  end
end