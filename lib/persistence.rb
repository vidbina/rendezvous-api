class Persistence
  def initialize(adaptor)
    @store = adaptor
    @connection_attempt = 3
  end

  def get_new_id_for_user(name, details=nil)
    @connection_attempt.times do |attempt|
      token = SecureRandom.hex
      p "#{attempt} of #{@connection_attempt} w/ #{token}"
      return token if @store.save_if_nonexistent("user:#{token}", name)
    end
    false
  end

  def save(id, val)
    return @store.save_and_possibly_overwrite(id, val)
  end

  def get(id)
    return @store.get(id)
  end
end
