class RedisAdaptor
  def initialize(tokens, redis)
    @tokens = tokens
    @redis = redis
  end

  def save_if_nonexistent(id, val)
    (true if @redis.setnx(id, val) == "OK") or false
  end

  def save_and_possibly_overwrite(id, val)
    (true if @redis.set(id, val) == "OK") or false
  end

  def get(id)
    @redis.get(id)
    #(true if @redis.get(id) == "OK") or false
  end
end
